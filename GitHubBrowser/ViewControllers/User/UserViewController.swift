//
//  UserViewController.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 01/10/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Action

class UserViewController: UIViewController, BindableType {
    var viewModel: UserViewModel!
    private var userView: UserView!
    
    convenience init(viewModel: UserViewModel) {
        self.init()
        self.viewModel = viewModel
        self.title = viewModel.repositoryOwner.login
        userView = UserView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        bindViewModel()
    }
    
    func initialSetup() {
        self.view.addSubview(userView)
        userView.autoPinEdgesToSuperviewEdges()
        userView.configure(with: viewModel.repositoryOwner)
    }
    
    func bindViewModel() {
        userView.viewOnWeb.rx.action = self.viewModel.openInSafari(from: self)
    }
}
