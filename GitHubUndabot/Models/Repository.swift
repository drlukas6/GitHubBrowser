//
//  Repository.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 28/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import SwiftyJSON

class Repository {
    var name: String
    var owner: Owner
    var watchers: Int
    var forks: Int
    var issues: Int
    var description: String
    
    private enum RepoKeys {
        static let name = "name"
        static let watchers = "watchers"
        static let forks = "forks"
        static let issues = "open_issues"
        static let description = "description"
        static let owner = "owner"
    }
    
    init(JSON: JSON) {
        self.name = JSON[RepoKeys.name].string ?? ""
        self.watchers = JSON[RepoKeys.watchers].int ?? 0
        self.forks = JSON[RepoKeys.forks].int ?? 0
        self.issues = JSON[RepoKeys.issues].int ?? 0
        self.description = JSON[RepoKeys.description].string ?? ""
        self.owner = Owner(JSON: JSON[RepoKeys.owner])
    }
}
