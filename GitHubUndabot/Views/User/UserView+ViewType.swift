//
//  UserView+ViewType.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 01/10/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

extension UserView: ViewType {
    func initializeSubviews() {
        self.avatarImage = UIImageView()
        self.usernameLabel = UILabel()
        self.nameLabel = UILabel()
        self.bioLabel = UILabel()
        self.locationLabel = UILabel()
        self.blogLabel = UILabel()
        self.followersLabel = UILabel()
        self.followingLabel = UILabel()
        self.infoStackView = UIStackView(arrangedSubviews: [usernameLabel,
                                                            nameLabel,
                                                            bioLabel,
                                                            locationLabel,
                                                            blogLabel,
                                                            followingLabel,
                                                            followersLabel])
        self.viewOnWeb = UIButton(type: .system)
    }
    
    func addSubviews() {
        self.addSubview(avatarImage)
        self.addSubview(infoStackView)
        self.addSubview(viewOnWeb)
    }
    
    func setupSubviews() {
        self.backgroundColor = .white
        
        avatarImage.autoAlignAxis(toSuperviewAxis: .vertical)
        avatarImage.autoPinEdge(toSuperviewSafeArea: .top, withInset: ViewProperty.inset.small)
        avatarImage.autoSetDimensions(to: ViewProperty.size.largeImage)
        avatarImage.clipsToBounds = true
        avatarImage.layer.borderColor = ViewProperty.color.undabotBlue.cgColor
        avatarImage.layer.borderWidth = ViewProperty.size.borderWidth
        avatarImage.layer.cornerRadius = ViewProperty.size.largeImageCorner
        
        infoStackView.autoPinEdge(.top,
                                  to: .bottom,
                                  of: avatarImage,
                                  withOffset: ViewProperty.inset.small)
        infoStackView.autoPinEdge(toSuperviewSafeArea: .leading,
                                  withInset: ViewProperty.inset.small)
        infoStackView.autoPinEdge(toSuperviewSafeArea: .trailing,
                                  withInset: ViewProperty.inset.small)
        infoStackView.axis = .vertical
        infoStackView.alignment = .center
        infoStackView.spacing = ViewProperty.size.defaultStackViewSpacing
        
        bioLabel.lineBreakMode = .byWordWrapping
        bioLabel.numberOfLines = 0
        bioLabel.textAlignment = .center
        
        blogLabel.lineBreakMode = .byWordWrapping
        blogLabel.numberOfLines = 0
        blogLabel.textAlignment = .center
        
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
