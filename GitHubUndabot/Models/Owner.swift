//
//  Owner.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 28/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import SwiftyJSON

class Owner {
    var avatar: URL?
    var login: String
    
    private enum OwnerKeys {
        static let avatar = "avatar_url"
        static let login = "login"
    }
    
    init(JSON: JSON) {
        self.avatar = JSON[OwnerKeys.avatar].url ?? nil
        self.login = JSON[OwnerKeys.login].string ?? ""
    }
}
