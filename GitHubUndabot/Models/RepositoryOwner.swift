//
//  RepositoryOwner.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 28/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import SwiftyJSON

class RepositoryOwner {
    var avatar: URL
    var login: String
    var name: String
    var blog: String
    var location: String
    var bio: String
    var followers: Int
    var following: Int
    var ownerUrl: URL
    
    private enum OwnerKeys {
        static let avatar = "avatar_url"
        static let login = "login"
        static let name = "name"
        static let blog = "blog"
        static let location = "location"
        static let bio = "bio"
        static let followers = "followers"
        static let following = "following"
        static let ownerUrl = "html_url"
    }
    
    init(JSON: JSON) {
        self.avatar = JSON[OwnerKeys.avatar].url!
        self.login = JSON[OwnerKeys.login].string ?? ""
        self.name = JSON[OwnerKeys.name].string ?? ""
        self.blog = JSON[OwnerKeys.blog].string ?? ""
        self.location = JSON[OwnerKeys.location].string ?? ""
        self.bio = JSON[OwnerKeys.bio].string ?? ""
        self.followers = JSON[OwnerKeys.followers].int ?? 0
        self.following = JSON[OwnerKeys.following].int ?? 0
        self.ownerUrl = JSON[OwnerKeys.ownerUrl].url!
    }
}
