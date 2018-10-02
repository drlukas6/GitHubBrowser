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
        static let user = "/user"
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
    
    enum OAuth {
        static let clientId = "d32691e44d052c172f21"
        static let secretClientId = "0ed6200efb03e5022629df40953b4cfcfa7254bb"
        static let scope = "user"
        enum parameterKeys {
            static let clientId =  "client_id"
            static let secretClientId = "client_secret"
            static let code = "code"
            static let scope = "scope"
            static let token = "access_token"
        }
        static let jsonHeader = ("Accept", "application/json")
    }
    
    func getAuthorizationUrl() -> URL? {
        guard
            let baseUrl = URL(string: "https://github.com/login/oauth/authorize"),
            let urlComponents = NSURLComponents(url: baseUrl, resolvingAgainstBaseURL: true) else {
            return nil
        }
        urlComponents.queryItems = [URLQueryItem(name: OAuth.parameterKeys.clientId,
                                                 value: OAuth.clientId),
                                    URLQueryItem(name: OAuth.parameterKeys.scope,
                                                 value: OAuth.scope)]
        guard let url = urlComponents.url else { return nil }
        return url
    }
    
    func getToken(with code: String) -> Observable<JSON> {
        guard
            let url = URL(string: "https://github.com/login/oauth/access_token"),
            let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return Observable.empty()
        }
        urlComponents.queryItems = [URLQueryItem(name: OAuth.parameterKeys.clientId,
                                                 value: OAuth.clientId),
                                    URLQueryItem(name: OAuth.parameterKeys.secretClientId,
                                                 value: OAuth.secretClientId),
                                    URLQueryItem(name: OAuth.parameterKeys.code,
                                                 value: code)]
        guard let urlWithParameters = urlComponents.url else { return Observable.empty() }
        var request = URLRequest(url: urlWithParameters)
        request.httpMethod = "POST"
        request.addValue(OAuth.jsonHeader.1, forHTTPHeaderField: OAuth.jsonHeader.0)
        let urlSession = URLSession.shared
        return urlSession.rx.data(request: request).map { try JSON(data: $0) }
    }
    
    func getUser(token: String) -> Observable<RepositoryOwner> {
        return performRequest(urlMethod: UrlMethod.GET,
                              pathComponent: PathComponent.user,
                              params: [(OAuth.parameterKeys.token, token)])
            .flatMap { json -> Observable<RepositoryOwner> in
                //                Assures the user exists
                guard json["login"].string != nil else {
                    return Observable.empty()
                }
                return Observable.just(RepositoryOwner(JSON: json))
        }
        
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
