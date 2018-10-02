//
//  RepositoryViewModel.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 30/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import RxSwift
import Action
import SafariServices

struct RepositoryViewModel: Router {
    let repository: Repository
    let repositoryOwner = PublishSubject<RepositoryOwner>()
    let disposeBag = DisposeBag()
 
    func getOwner() {
        ApiController.shared.getUser(for: repository.ownerLogin)
            .subscribe(onNext: { self.repositoryOwner.onNext($0) })
            .disposed(by: disposeBag)
    }
    
    func openInSafari(from viewController: UIViewController) -> CocoaAction {
        return CocoaAction { _ in
            let safariViewController = SFSafariViewController(url: self.repository.repoURL)
            safariViewController.preferredControlTintColor = .white
            safariViewController.preferredBarTintColor = ViewProperty.color.undabotBlue
            viewController.present(safariViewController, animated: true, completion: nil)
            return Observable.empty()
        }
    }
}
