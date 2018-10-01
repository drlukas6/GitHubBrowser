//
//  UserView.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 01/10/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class UserView: UIView, ViewType {
    private var avatarImage: UIImageView!
    private var usernameLabel: UILabel!
    private var nameLabel: UILabel!
    private var bioLabel: UILabel!
    private var locationLabel: UILabel!
    private var blogLabel: UILabel!
    private var followersLabel: UILabel!
    private var followingLabel: UILabel!
    private var infoStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    }
    
    func addSubviews() {
        self.addSubview(avatarImage)
        self.addSubview(infoStackView)
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
    }
    
    func configure(with repositoryOwner: RepositoryOwner) {
        self.avatarImage.kf.setImage(with: repositoryOwner.avatar)
        self.usernameLabel.text = "Login: \(repositoryOwner.login)"
        self.nameLabel.text = "Name: \(repositoryOwner.name)"
        self.bioLabel.text = "Bio: \(repositoryOwner.bio)"
        self.blogLabel.text = "Blog: \(repositoryOwner.blog)"
        self.followersLabel.text = "Followers: \(repositoryOwner.followers)"
        self.followingLabel.text = "Following: \(repositoryOwner.following)"
    }
    
    

}

