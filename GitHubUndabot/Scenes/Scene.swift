//
//  Scene.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 29/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import Action

enum Scene {
    case queryScene(QueryViewModel)
    case repositoryScene(RepositoryViewModel)
    case userScene(UserViewModel)
    case loginScene(LoginViewModel)
}

extension Scene {
    func viewController() -> UIViewController {
        switch self {
        case .loginScene(let viewModel):
            let viewController = LoginViewController(viewModel: viewModel)
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.navigationBar.tintColor = ViewProperty.color.undabotBlue
            if #available(iOS 11.0, *) {
                navigationController.navigationBar.prefersLargeTitles = true
            }
            return navigationController
        case .queryScene(let viewModel):
            return QueryViewController(viewModel: viewModel)
        case .repositoryScene(let viewModel):
            return RepositoryViewController(viewModel: viewModel)
        case .userScene(let viewModel):
            return UserViewController(viewModel: viewModel)
        }
    }
}

