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
}

extension Scene {
    func viewController() -> UIViewController {
        switch self {
        case .queryScene(let viewModel):
            let viewController = QueryViewController()
            return viewController
        }
    }
}

