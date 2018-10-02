//
//  AppDelegate.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 28/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let disposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let initialScene = Scene.loginScene(LoginViewModel())
        window?.rootViewController = initialScene.viewController()
        window?.makeKeyAndVisible()
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if (url.absoluteString.contains("gitundabot")) {
//            Removing safari auth view
            UIApplication.shared.topMostViewController()?.dismiss(animated: false, completion: nil)
            let repositoryOwner = PublishSubject<RepositoryOwner>()
            
            repositoryOwner
                .asObservable()
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { repositoryOwner in
                    guard let topViewController = UIApplication.shared.topMostViewController() as? LoginViewController else {
                        return
                    }
                    let viewModel = UserViewModel(repositoryOwner: repositoryOwner)
                    let userScene = Scene.userScene(viewModel)
                    topViewController.viewModel.transitionTo(scene: userScene, context: topViewController)
                })
                .disposed(by: disposeBag)
            
            guard let code = url.getUrlParameter(param: ApiController.OAuth.parameterKeys.code) else { return true }
            ApiController.shared.getToken(with: code)
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { json in
                    guard let token = json[ApiController.OAuth.parameterKeys.token].string else {
                        return
                    }
                    ApiController.shared.getUser(token: token)
                        .subscribe(repositoryOwner)
                        .disposed(by: self.disposeBag)
                })
                .disposed(by: disposeBag)
        }
        return true
    }
}

extension URL {
    func getUrlParameter(param: String) -> String? {
        guard let url = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return nil
        }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
}


extension UIViewController {
    func topMostViewController() -> UIViewController {
        
        if let presented = self.presentedViewController {
            return presented.topMostViewController()
        }
        
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }
        
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }
        
        return self
    }
}


extension UIApplication {
    func topMostViewController() -> UIViewController? {
        return self.keyWindow?.rootViewController?.topMostViewController()
    }
}
