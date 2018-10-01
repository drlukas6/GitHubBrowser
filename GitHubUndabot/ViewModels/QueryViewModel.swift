//
//  QueryViewModel.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 28/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON
import Action

struct QueryViewModel: Router {
    
    private let disposeBag = DisposeBag()
    var queryResults: Variable<[Repository]> = Variable([])
    
    func search(query: String, sortType: String) {
        ApiController.shared.searchRepositories(for: query, sortType: sortType)
        .bind(to: queryResults)
        .disposed(by: disposeBag)
    }
    
    func transitionTo(scene: Scene, context: UIViewController)  -> Completable {
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
    
    
}

