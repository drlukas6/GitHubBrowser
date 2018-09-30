//
//  RepositoryViewController.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 30/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import UIKit

class RepositoryViewController: UIViewController, BindableType {
    internal var viewModel: RepositoryViewModel!
    private var repositoryView: RepositoryView!

    convenience init(viewModel: RepositoryViewModel) {
        self.init()
        self.viewModel = viewModel
        self.title = viewModel.repository.name.uppercased()
        repositoryView = RepositoryView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        bindViewModel()
    }
    
    private func initialSetup() {
        self.view.addSubview(repositoryView)
        repositoryView.autoPinEdgesToSuperviewEdges()
        repositoryView.configureView(with: viewModel.repository)
    }
    
    func bindViewModel() {
        
    }
}
