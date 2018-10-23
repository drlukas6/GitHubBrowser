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
import SafariServices

struct LoginViewModel: Router {
    var RepositoryOwner = PublishSubject<RepositoryOwner>()
    
    func searchAction(from viewController: UIViewController) -> CocoaAction {
        return CocoaAction { _ in
            let queryScene = Scene.queryScene(QueryViewModel())
            self.transitionTo(scene: queryScene, context: viewController)
            return Observable.empty()
        }
    }
    
    func authorizationAction(from viewController: UIViewController) -> CocoaAction {
        return CocoaAction { _ in
            guard let url = ApiController.shared.getAuthorizationUrl() else { return Observable.empty() }
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.preferredControlTintColor = .white
            safariViewController.preferredBarTintColor = ViewProperty.color.seaBlue
            viewController.present(safariViewController, animated: true, completion: nil)
            return Observable.empty()
        }
    }
}
