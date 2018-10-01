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
    var ownerAvatar: URL
    var ownerLogin: String
    var watchers: Int
    var forks: Int
    var issues: Int
    var description: String
    var updated: Date
    var created: Date
    var language: String
    var license: String
    
    private enum RepoKeys {
        static let name = "name"
        static let watchers = "watchers"
        static let forks = "forks"
        static let issues = "open_issues"
        static let description = "description"
        static let owner = "owner"
        static let ownerAvatar = "avatar_url"
        static let login = "login"
        static let updated = "updated_at"
        static let created = "created_at"
        static let language = "language"
        static let license = "license"
    }
    
    init(JSON: JSON) {
        self.name = JSON[RepoKeys.name].string ?? ""
        self.watchers = JSON[RepoKeys.watchers].int ?? 0
        self.forks = JSON[RepoKeys.forks].int ?? 0
        self.issues = JSON[RepoKeys.issues].int ?? 0
        self.description = JSON[RepoKeys.description].string ?? ""
        self.ownerAvatar = JSON[RepoKeys.owner][RepoKeys.ownerAvatar].url!
        self.ownerLogin = JSON[RepoKeys.owner][RepoKeys.login].string ?? ""
        self.language = JSON[RepoKeys.language].string ?? ""
        self.license = JSON[RepoKeys.license][RepoKeys.name].string ?? ""
        let lastUpdated = JSON[RepoKeys.updated].string ?? ""
        let createdAt = JSON[RepoKeys.created].string ?? ""
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        self.updated = formatter.date(from: lastUpdated) ?? Date()
        self.created = formatter.date(from: createdAt) ?? Date()
    }
}
