//
//  RepositoryView.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 30/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import PureLayout
import UIKit
import RxSwift
import RxGesture

class RepositoryView: UIView {
    var repoDescription: UILabel!
    var authorView: UIView!
    var authorLabel: UILabel!
    var avatarImage: UIImageView!
    var authorName: UILabel!
    var statisticsStackView: UIStackView!
    var statisticsLabel: UILabel!
    var language: UILabel!
    var noIssues: UILabel!
    var noWatchers: UILabel!
    var noForks: UILabel!
    var updated: UILabel!
    var created: UILabel!
    var license: UILabel!
    var viewOnWeb: UIButton!
    
    private var viewModel: RepositoryViewModel!
    private var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        designView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        designView()
    }
    
    func configureView(with repo: Repository) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        self.repoDescription.text = repo.description
        self.avatarImage.kf.setImage(with: repo.ownerAvatar)
        self.authorName.text = repo.ownerLogin
        self.language.text = "LANGUAGE: \(repo.language)"
        self.noIssues.text = "ISSUES: \(repo.issues)"
        self.noWatchers.text = "WATCHERS: \(repo.watchers)"
        self.noForks.text = "FORKS: \(repo.forks)"
        self.updated.text = "UPDATED: \(formatter.string(from: repo.updated))"
        self.created.text = "CREATED: \(formatter.string(from: repo.created))"
        self.license.text = "LICENSE: \(repo.license)"
    }
    
    func bind(with viewModel: RepositoryViewModel) {
        
        self.authorView.rx.gesture(.tap())
            .throttle(0.5, scheduler: MainScheduler.instance)
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.getOwner()
            })
            .disposed(by: self.disposeBag)
    }
}
