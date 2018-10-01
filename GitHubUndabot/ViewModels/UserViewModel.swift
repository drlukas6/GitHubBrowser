//
//  UserViewModel.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 01/10/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import RxSwift
import Action
import SafariServices

struct UserViewModel {
    let repositoryOwner: RepositoryOwner
    
    func openInSafari(from viewController: UIViewController) -> CocoaAction {
        return CocoaAction { _ in
            let safariViewController = SFSafariViewController(url: self.repositoryOwner.ownerUrl)
            safariViewController.preferredControlTintColor = .white
            safariViewController.preferredBarTintColor = ViewProperty.color.undabotBlue
            viewController.present(safariViewController, animated: true, completion: nil)
            return Observable.empty()
        }
    }
}
