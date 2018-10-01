//
//  Scene.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 29/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Action
enum Scene {
    case queryScene(QueryViewModel)
    case repositoryScene(RepositoryViewModel)
    case userScene(UserViewModel)
}

protocol Router {
    func transitionTo(scene: Scene, context: UIViewController) -> Completable
}


extension Scene {
    func viewController() -> UIViewController {
        switch self {
        case .queryScene(let viewModel):
            let viewController = QueryViewController(viewModel: viewModel)
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.navigationBar.tintColor = ViewProperty.color.undabotBlue
            if #available(iOS 11.0, *) {
                navigationController.navigationBar.prefersLargeTitles = true
            }
            return navigationController
        case .repositoryScene(let viewModel):
            return RepositoryViewController(viewModel: viewModel)
        case .userScene(let userViewModel):
            return UIViewController()
        }
    }
}

