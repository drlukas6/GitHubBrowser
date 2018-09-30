//
//  Scene.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 29/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit

enum Scene {
    case queryScene(QueryViewModel)
    case repositoryScene(RepositoryViewModel)
}

protocol Router {
    func transitionTo(scene: Scene, context: UIViewController)
}

extension Scene {
    func viewController() -> UIViewController {
        switch self {
        case .queryScene(let viewModel):
            let viewController = QueryViewController(viewModel: viewModel)
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.navigationBar.tintColor = ViewProperty.color.undabotBlue
            return navigationController
        case .repositoryScene(let viewModel):
            return UIViewController()
        }
    }
}

