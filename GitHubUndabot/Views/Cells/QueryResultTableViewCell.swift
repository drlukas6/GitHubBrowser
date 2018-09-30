//
//  QueryResultTableViewCell.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 29/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import PureLayout
import Kingfisher

class QueryResultTableViewCell: UITableViewCell, ViewType {
    private var containerView: UIView!
    private var avatarImage: UIImageView!
    private var repoName: UILabel!
    private var noWatchers: UILabel!
    private var noForks: UILabel!
    private var noIssues: UILabel!
    private var repoDescription: UILabel!
    private var author: UILabel!
    private var lastUpdated: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeSubviews()
        addSubviews()
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
        addSubviews()
        setupSubviews()
    }
    
    func initializeSubviews() {
        self.containerView = UIView(frame: .zero)
        self.avatarImage = UIImageView()
        self.repoName = UILabel()
        self.noWatchers = UILabel()
        self.noForks = UILabel()
        self.noIssues = UILabel()
        self.repoDescription = UILabel()
        self.author = UILabel()
        self.lastUpdated = UILabel()
        
    }
    
    func addSubviews() {
        self.addSubview(containerView)
        containerView.addSubview(avatarImage)
        containerView.addSubview(repoName)
        containerView.addSubview(repoDescription)
        containerView.addSubview(noWatchers)
        containerView.addSubview(noForks)
        containerView.addSubview(noIssues)
        containerView.addSubview(author)
        containerView.addSubview(lastUpdated)
    }
    
    func setupSubviews() {
        self.backgroundColor = .clear
        
        containerView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: ViewProperty.inset.small,
                                                                      left: ViewProperty.inset.small,
                                                                      bottom: ViewProperty.inset.small,
                                                                      right: ViewProperty.inset.small))
        containerView.backgroundColor = ViewProperty.color.undabotBlue
        containerView.layer.cornerRadius = ViewProperty.size.defaultCorner


        
        avatarImage.autoPinEdge(.top,
                                to: .top,
                                of: containerView,
                                withOffset: ViewProperty.inset.small)
        avatarImage.autoPinEdge(.leading,
                                to: .leading,
                                of: containerView,
                                withOffset: ViewProperty.inset.small)
        avatarImage.autoSetDimensions(to: ViewProperty.size.smallImage)
        avatarImage.layer.masksToBounds = true
        avatarImage.layer.borderColor = UIColor.white.cgColor
        avatarImage.layer.borderWidth = ViewProperty.size.borderWidth
        avatarImage.layer.cornerRadius = ViewProperty.size.smallImageCorner
        
        repoName.autoPinEdge(.top, to: .top, of: avatarImage)
        repoName.autoPinEdge(.leading,
                             to: .trailing,
                             of: avatarImage,
                             withOffset: ViewProperty.inset.small)
        repoName.autoPinEdge(.trailing,
                                    to: .trailing,
                                    of: containerView,
                                    withOffset: -ViewProperty.inset.small)
        repoName.font = UIFont.boldSystemFont(ofSize: ViewProperty.size.largeFont)
        repoName.textColor = .white
        repoName.numberOfLines = 0
        repoName.lineBreakMode = .byWordWrapping
        
        repoDescription.autoPinEdge(.top,
                                    to: .bottom,
                                    of: repoName, withOffset: ViewProperty.inset.continous)
        repoDescription.autoPinEdge(.leading,
                                    to: .trailing,
                                    of: avatarImage,
                                    withOffset: ViewProperty.inset.small)
        repoDescription.autoPinEdge(.trailing,
                                    to: .trailing,
                                    of: containerView,
                                    withOffset: -ViewProperty.inset.small)
        repoDescription.font = UIFont(descriptor: repoDescription.font.fontDescriptor,
                                      size: ViewProperty.size.smallFont)
        repoDescription.textColor = .white
        repoDescription.numberOfLines = 0
        repoDescription.lineBreakMode = .byWordWrapping
        
        noForks.autoPinEdge(.leading,
                            to: .leading,
                            of: containerView,
                            withOffset: ViewProperty.inset.large)
        noForks.autoPinEdge(.top,
                            to: .bottom,
                            of: avatarImage,
                            withOffset: ViewProperty.inset.small)
        noForks.textColor = .white
        
        noWatchers.autoPinEdge(.top,
                               to: .bottom,
                               of: avatarImage,
                               withOffset: ViewProperty.inset.small)
        noWatchers.autoPinEdge(.trailing,
                               to: .trailing,
                               of: containerView,
                               withOffset: -ViewProperty.inset.large)
        noWatchers.textColor = .white
        
        noIssues.autoPinEdge(.top,
                             to: .bottom,
                             of: noForks,
                             withOffset: ViewProperty.inset.small)
        noIssues.autoPinEdge(.leading,
                             to: .leading,
                             of: containerView,
                             withOffset: ViewProperty.inset.large)
        noIssues.textColor = .white
        
        lastUpdated.autoPinEdge(.top,
                                to: .bottom,
                                of: noWatchers,
                                withOffset: ViewProperty.inset.small)
        lastUpdated.autoPinEdge(.trailing,
                                to: .trailing,
                                of: containerView,
                                withOffset: -ViewProperty.inset.large)
        lastUpdated.textColor = .white
        
        author.autoPinEdge(.top,
                           to: .bottom,
                           of: noIssues,
                           withOffset: ViewProperty.inset.small)
        author.autoPinEdge(.leading,
                           to: .leading,
                           of: containerView,
                           withOffset: ViewProperty.inset.large)
        author.textColor = .white
        
        
    }
    
    func configureCell(with repo: Repository) {
        self.avatarImage.kf.setImage(with: repo.owner.avatar)
        self.repoName.text = repo.name
        self.repoDescription.text = repo.description
        self.noWatchers.text = "Watchers: \(repo.watchers)"
        self.noForks.text = "Forks: \(repo.forks)"
        self.noIssues.text = "Issues: \(repo.issues)"
        self.author.text = "Author: \(repo.owner.login)"
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        self.lastUpdated.text = "Updated: \(formatter.string(from: repo.updated))"
    }
}
