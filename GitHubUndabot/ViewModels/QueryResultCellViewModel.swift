//
//  QueryResultCellViewModel.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 01/10/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import RxSwift
import RxGesture

struct QueryResultCellViewModel: Router {
    let repository: Variable<Repository>
    let repositoryOwner = PublishSubject<RepositoryOwner>()
    let disposeBag = DisposeBag()
    

    
    func transitionTo(scene: Scene, context: UIViewController) -> Completable {
        let returningSubject = PublishSubject<Void>()
        guard let navigationController = context.navigationController else {
            fatalError("Cannot transition without a navigation controller")
        }
        _ = navigationController.rx.delegate
            .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
            .map { _ in}
            .bind(to: returningSubject)
        navigationController.pushViewController(scene.viewController(), animated: true)
        return returningSubject.asObservable()
            .take(1)
            .ignoreElements()
    }
    
    func getUser() {
        ApiController.shared.getUser(for: repository.value.ownerLogin)
            .subscribe(onNext: {self.repositoryOwner.onNext($0)})
            .disposed(by: disposeBag)
    }
    
    
}
