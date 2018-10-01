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
        return PublishSubject<Void>()
                .take(1)
                .asObservable()
                .ignoreElements()
    }
    
    
}
