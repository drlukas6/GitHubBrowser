//
//  QueryView.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 28/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit

class QueryView: UIView {
    var resultsTableView: UITableView!
    var searchBar: UISearchBar!
    var sortType: UISegmentedControl!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        designView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        designView()
    }
}
