//
//  RepositoryView+ViewType.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 01/10/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import PureLayout
import UIKit
import RxSwift
import RxGesture

extension RepositoryView: ViewType {
    internal func initializeSubviews() {
        self.repoDescription = UILabel()
        self.authorView = UIView(frame: .zero)
        self.authorLabel = UILabel()
        self.avatarImage = UIImageView()
        self.authorName = UILabel()
        self.statisticsLabel = UILabel()
        self.language = UILabel()
        self.noIssues = UILabel()
        self.noWatchers = UILabel()
        self.noForks = UILabel()
        self.updated = UILabel()
        self.created = UILabel()
        self.license = UILabel()
        self.viewOnWeb = UIButton(type: .system)
        self.statisticsStackView = UIStackView(arrangedSubviews: [language,
                                                                  noIssues,
                                                                  noWatchers,
                                                                  noForks,
                                                                  updated,
                                                                  created,
                                                                  license])
    }
    
    internal func addSubviews() {
        self.addSubview(repoDescription)
        self.addSubview(authorView)
        authorView.addSubview(authorLabel)
        authorView.addSubview(avatarImage)
        authorView.addSubview(authorName)
        self.addSubview(statisticsStackView)
        self.addSubview(viewOnWeb)
    }
    
    internal func setupSubviews() {
        self.backgroundColor = .white
        
        repoDescription.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: ViewProperty.inset.small,
                                                                           left: ViewProperty.inset.small,
                                                                           bottom: ViewProperty.inset.small,
                                                                           right: ViewProperty.inset.small),
                                                        excludingEdge: .bottom)
        
        repoDescription.lineBreakMode = .byWordWrapping
        repoDescription.numberOfLines = 0
        repoDescription.textColor = ViewProperty.color.undabotBlue
        
        authorView.clipsToBounds = true
        authorView.layer.cornerRadius = ViewProperty.size.defaultCorner
        authorView.layer.borderWidth = ViewProperty.size.borderWidth
        authorView.layer.borderColor = UIColor.white.cgColor
        authorView.backgroundColor = ViewProperty.color.undabotBlue
        authorView.autoPinEdge(.top, to: .bottom, of: repoDescription, withOffset: ViewProperty.inset.small)
        authorView.autoPinEdge(toSuperviewEdge: .leading, withInset: ViewProperty.inset.small)
        authorView.autoPinEdge(toSuperviewEdge: .trailing, withInset: ViewProperty.inset.small)
        authorView.autoSetDimension(.height, toSize: CGFloat(150.0))
        
        
        authorLabel.autoPinEdge(.top,
                                to: .top,
                                of: authorView,
                                withOffset: ViewProperty.inset.continous)
        authorLabel.autoPinEdge(.leading,
                                to: .leading,
                                of: authorView,
                                withOffset: ViewProperty.inset.small)
        authorLabel.text = "AUTHOR:"
        authorLabel.textColor = UIColor.white
        authorLabel.font = UIFont(descriptor: authorLabel.font.fontDescriptor, size: ViewProperty.size.smallFont)
        
        avatarImage.clipsToBounds = true
        avatarImage.layer.cornerRadius = ViewProperty.size.mediumImageCorner
        avatarImage.autoAlignAxis(toSuperviewAxis: .horizontal)
        avatarImage.autoPinEdge(toSuperviewEdge: .leading,
                                withInset: ViewProperty.inset.small)
        avatarImage.autoSetDimensions(to: ViewProperty.size.mediumImage)
        
        authorName.autoAlignAxis(toSuperviewAxis: .horizontal)
        authorName.autoPinEdge(.leading,
                               to: .trailing,
                               of: avatarImage,
                               withOffset: ViewProperty.inset.small)
        authorName.textColor = UIColor.white
        
        
        statisticsStackView.autoPinEdge(.top,
                                        to: .bottom,
                                        of: authorView,
                                        withOffset: ViewProperty.inset.continous)
        statisticsStackView.autoPinEdge(toSuperviewEdge: .leading,
                                        withInset: ViewProperty.inset.small)
        statisticsStackView.autoPinEdge(toSuperviewEdge: .trailing,
                                        withInset: ViewProperty.inset.small)
        statisticsStackView.axis = .vertical
        statisticsStackView.alignment = .center
        statisticsStackView.spacing = ViewProperty.size.defaultStackViewSpacing
        
        language.font = UIFont.boldSystemFont(ofSize: ViewProperty.size.largeFont)
        language.textColor = ViewProperty.color.undabotBlue
        
        noIssues.font = UIFont.boldSystemFont(ofSize: ViewProperty.size.largeFont)
        noIssues.textColor = ViewProperty.color.undabotBlue
        
        noWatchers.font = UIFont.boldSystemFont(ofSize: ViewProperty.size.largeFont)
        noWatchers.textColor = ViewProperty.color.undabotBlue
        
        noForks.font = UIFont.boldSystemFont(ofSize: ViewProperty.size.largeFont)
        noForks.textColor = ViewProperty.color.undabotBlue
        
        updated.font = UIFont.boldSystemFont(ofSize: ViewProperty.size.largeFont)
        updated.textColor = ViewProperty.color.undabotBlue
        
        created.font = UIFont.boldSystemFont(ofSize: ViewProperty.size.largeFont)
        created.textColor = ViewProperty.color.undabotBlue
        
        license.font = UIFont.boldSystemFont(ofSize: ViewProperty.size.largeFont)
        license.textColor = ViewProperty.color.undabotBlue
        license.lineBreakMode = .byWordWrapping
        license.numberOfLines = 0
        
        viewOnWeb.setTitle("VIEW ON WEB", for: .normal)
        viewOnWeb.setTitleColor(.white, for: .normal)
        viewOnWeb.backgroundColor = ViewProperty.color.undabotBlue
        viewOnWeb.layer.cornerRadius = ViewProperty.size.defaultCorner
        viewOnWeb.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: ViewProperty.inset.small,
                                                                     left: ViewProperty.inset.small,
                                                                     bottom: ViewProperty.inset.small,
                                                                     right: ViewProperty.inset.small),
                                                  excludingEdge: .top)
        viewOnWeb.autoSetDimension(.height, toSize: ViewProperty.size.buttonHeight)
    }
}
