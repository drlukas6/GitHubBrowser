//
//  QueryViewModel.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 28/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import RxSwift
import Action
import SwiftyJSON

struct QueryViewModel {
    var queryResults: Variable<[Repository]> = Variable([])
    
    func search(query: String) {
        ApiController.shared.searchRepositories(for: query)
        .bind(to: queryResults)
    }
}
