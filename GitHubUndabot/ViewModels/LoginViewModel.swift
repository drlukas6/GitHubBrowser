//
//  LoginViewModel.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 02/10/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import RxSwift
import Action
import OAuthSwift

struct LoginViewModel: Router {
    var RepositoryOwner = PublishSubject<RepositoryOwner>()
    var oauthswift: OAuthSwift!
    
    func searchAction(from viewController: UIViewController) -> CocoaAction {
        return CocoaAction { _ in
            let queryScene = Scene.queryScene(QueryViewModel())
            self.transitionTo(scene: queryScene, context: viewController)
            return Observable.empty()
        }
    }
    9
//    mutating func doOAuthGithub(_ serviceParameters: [String:String]){
//        let oauthswift = OAuth2Swift(
//            consumerKey:    serviceParameters["consumerKey"]!,
//            consumerSecret: serviceParameters["consumerSecret"]!,
//            authorizeUrl:   "https://github.com/login/oauth/authorize",
//            accessTokenUrl: "https://github.com/login/oauth/access_token",
//            responseType:   "code"
//        )
//        self.oauthswift = oauthswift
//        oauthswift.authorizeURLHandler = getURLHandler()
//        let state = generateState(withLength: 20)
//        let _ = oauthswift.authorize(
//            withCallbackURL: URL(string: "oauth-swift://oauth-callback/github")!, scope: "user,repo", state: state,
//            success: { credential, response, parameters in
//                print(response)
//                print(credential)
//                print(parameters)
////                self.showTokenAlert(name: serviceParameters["name"], credential: credential)
//            },
//            failure: { error in
//                print(error.description)
//            }
//        )
//    }
//
}
