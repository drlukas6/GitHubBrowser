//
//  RepositoryViewController.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 30/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import UIKit
import RxSwift
import RxGesture

class RepositoryViewController: UIViewController, BindableType {
    internal var viewModel: RepositoryViewModel!
    private var repositoryView: RepositoryView!
    private var disposeBag = DisposeBag()

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
        repositoryView
            .authorView
            .rx
            .gesture(.tap())
            .throttle(0.5, scheduler: MainScheduler.instance)
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.getOwner()
            })
            .disposed(by: disposeBag)
        
        self.viewModel.repositoryOwner
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { repositoryOwner in
                let userViewModel = UserViewModel(repositoryOwner: repositoryOwner)
                let userScene = Scene.userScene(userViewModel)
                self.viewModel
                    .transitionTo(scene: userScene, context: self)
            })
            .disposed(by: disposeBag)
    }
}

