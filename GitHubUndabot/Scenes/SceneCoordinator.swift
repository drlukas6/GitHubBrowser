//
//  SceneCoordinator.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 01/10/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class SceneCoordinator: SceneCoordinatorType {
    private var currentViewController: UIViewController
    
    required init(currentViewController: UIViewController) {
        self.currentViewController = currentViewController
    }
    
    static func visibleViewController(for viewController: UIViewController) -> UIViewController {
        if let navigationController = viewController as? UINavigationController, let firstVc = navigationController.viewControllers.first {
            return firstVc
        }
        else {
            return viewController
        }
    }
    
    
    func transition(to scene: Scene, type: SceneTransitionType) -> Completable {
        let returnSubject = PublishSubject<Void>()
        let viewController = scene.viewController()
        switch type {
        case .push:
            guard let navigationController = currentViewController.navigationController else {
                fatalError("For pushing a scene, navigation controller is neccessary")
            }
            _ = navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .map { _ in}
                .bind(to: returnSubject)
            navigationController.pushViewController(viewController, animated: true)
            currentViewController = SceneCoordinator.visibleViewController(for: viewController)
        }
        return returnSubject.asObservable()
                .take(1)
                .ignoreElements()
    }
    
    func pop(animated: Bool) -> Completable {
        let returnSubject = PublishSubject<Void>()
        if let navigationController = currentViewController.navigationController {
            _ = navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .map { _ in}
                .bind(to: returnSubject)
        }
        else {
            fatalError("Cannot pop without a NavigationController")
        }
        return returnSubject.asObservable()
                .take(1)
                .ignoreElements()
    }
}
