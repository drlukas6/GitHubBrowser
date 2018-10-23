//
//  UserView.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 01/10/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit

class UserView: UIView {
    var avatarImage: UIImageView!
    var usernameLabel: UILabel!
    var nameLabel: UILabel!
    var bioLabel: UILabel!
    var locationLabel: UILabel!
    var blogLabel: UILabel!
    var followersLabel: UILabel!
    var followingLabel: UILabel!
    var infoStackView: UIStackView!
    var viewOnWeb: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        designView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        designView()
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

