//
//  ApiController.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 28/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

class ApiController {
    static let shared = ApiController()
    private let disposeBag = DisposeBag()
    
    var rootEndpoint: URL {
        guard let endpoint = URL(string: "https://api.github.com") else {
            fatalError("Root Endpoint is invalid. App Cannot function without it.")
        }
        return endpoint
    }
    
    enum PathComponent {
        static let repositories = "search/repositories"
        static let users = "/users"
    }
    
    enum UrlMethod {
        static let GET = "GET"
        static let POST = "POST"
    }
    
    enum Parameter  {
        static let query = "q"
        static let sort = "sort"
    }
    
    enum UserField {
        static let followers = "followers"
        static let subscriptions = "subscriptions"
        static let repos = "repos_url"
        static let type = "type"
        static let score = "score"
    }
    
    func getUser(for username: String) -> Observable<RepositoryOwner> {
        return performRequest(urlMethod: UrlMethod.GET, pathComponent: "\(PathComponent.users)/\(username)", params: [])
            .flatMap { json -> Observable<RepositoryOwner> in
//                Assures the user exists
                guard json["login"].string != nil else {
                    return Observable.empty()
                }
                return Observable.just(RepositoryOwner(JSON: json))
            }
    }
    
    func searchRepositories(for inquiry: String, sortType: String) -> Observable<[Repository]> {
        return performRequest(urlMethod: UrlMethod.GET,
                       pathComponent: PathComponent.repositories,
                       params: [(Parameter.query, inquiry), (Parameter.sort, sortType)])
            .flatMap { json -> Observable<[Repository]> in
                guard let unparsedResult = json["items"].array else { return Observable.empty() }
                return Observable.just(unparsedResult.map(Repository.init))
            }
    }
    
    private func performRequest(urlMethod: String, pathComponent: String, params: [(String, String)]) -> Observable<JSON> {
        let baseUrl = rootEndpoint.appendingPathComponent(pathComponent)
        guard
            let urlComponents = NSURLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
            else { fatalError() }
        urlComponents.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        guard
            let url = urlComponents.url
            else { fatalError() }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = urlMethod
        
        let urlSession = URLSession.shared
        
        return urlSession.rx.data(request: urlRequest).map { try JSON(data: $0) }
    }
    
}
