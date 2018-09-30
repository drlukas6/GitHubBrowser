//
//  QueryViewModel.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 28/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import RxSwift
import Action
import SwiftyJSON

struct QueryViewModel: Router {
    private let disposeBag = DisposeBag()
    var queryResults: Variable<[Repository]> = Variable([])
    
    func search(query: String, sortType: String) {
        ApiController.shared.searchRepositories(for: query, sortType: sortType)
        .bind(to: queryResults)
        .disposed(by: disposeBag)
    }
    
    func transitionTo(scene: Scene, context: UIViewController) {
        context.navigationController?.pushViewController(scene.viewController(), animated: true)
    }
}

