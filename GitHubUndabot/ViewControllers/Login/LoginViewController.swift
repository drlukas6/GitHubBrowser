//
//  LoginViewController.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 02/10/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Action

class LoginViewController: UIViewController, BindableType {
    private var loginView: LoginView!
    private var disposeBag = DisposeBag()
    var viewModel: LoginViewModel!
    
    convenience init(viewModel: LoginViewModel) {
        self.init()
        self.viewModel = viewModel
        loginView = LoginView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    private func initialSetup() {
        self.view.addSubview(loginView)
        loginView.autoPinEdgesToSuperviewEdges()
    }
    
    func bindViewModel() {
        loginView.gotoSearchButton.rx.action = viewModel.searchAction(from: self)
        
    }
}
