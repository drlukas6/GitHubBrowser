//
//  SceneCoordinatorType.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 01/10/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    func transition(to scene: Scene, type: SceneTransitionType) -> Completable
    
    func pop(animated: Bool) -> Completable
}

enum SceneTransitionType {
    case push
}
