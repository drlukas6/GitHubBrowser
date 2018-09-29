//
//  QueryResultTableViewCell.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 29/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import PureLayout

class QueryResultTableViewCell: UIView, ViewType {
    private var containerView: UIView!
    private var repoName: UILabel!
    private var noWatchers: UILabel!
    private var noForks: UILabel!
    private var noIssues: UILabel!
    private var repoDescription: UILabel!
    
    func initializeSubviews() {
        self.containerView = UIView(frame: .zero)
        self.repoName = UILabel()
        self.noWatchers = UILabel()
        self.noForks = UILabel()
        self.noIssues = UILabel()
        self.repoDescription = UILabel()
    }
    
    func addSubviews() {
        containerView.addSubview(repoName)
        containerView.addSubview(noWatchers)
        containerView.addSubview(noForks)
        containerView.addSubview(noIssues)
        containerView.addSubview(repoDescription)
    }
    
    func setupSubviews() {
        containerView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: ViewProperties.smallInset,
                                                                      left: ViewProperties.smallInset,
                                                                      bottom: ViewProperties.smallInset,
                                                                      right: ViewProperties.smallInset))
        containerView.backgroundColor = .gray
        containerView.layer.cornerRadius = ViewProperties.defaultCornerRadius
        
        noForks.autoPinEdge(.bottom,
                            to: .bottom,
                            of: containerView,
                            withOffset: -ViewProperties.smallInset)
        noForks.autoPinEdge(.leading,
                            to: .leading,
                            of: containerView,
                            withOffset: ViewProperties.smallInset)
        
        noWatchers.autoPinEdge(.bottom,
                            to: .bottom,
                            of: noForks,
                            withOffset: -ViewProperties.smallInset)
        noWatchers.autoPinEdge(.leading,
                            to: .leading,
                            of: containerView,
                            withOffset: ViewProperties.smallInset)
        
        repoDescription.autoPinEdge(.bottom,
                               to: .bottom,
                               of: noWatchers,
                               withOffset: -ViewProperties.smallInset)
        repoDescription.autoPinEdge(.leading,
                               to: .leading,
                               of: containerView,
                               withOffset: ViewProperties.smallInset)
        
        repoName.autoPinEdge(.bottom,
                                    to: .bottom,
                                    of: repoDescription,
                                    withOffset: -ViewProperties.smallInset)
        repoName.autoPinEdge(.leading,
                                    to: .leading,
                                    of: containerView,
                                    withOffset: ViewProperties.smallInset)
    }
    
    func configureCell(with repo: Repository) {
        self.repoName.text = repo.name
        self.repoDescription.text = repo.description
        self.noWatchers.text = "\(repo.watchers)"
        self.noForks.text = "\(repo.forks)"
        self.noIssues.text = "\(repo.issues)"
    }
}
