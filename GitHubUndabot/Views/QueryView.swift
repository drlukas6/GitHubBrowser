//
//  QueryView.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 28/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class QueryView: UIView, ViewType {
    var resultsTableView: UITableView!
    var searchBar: UISearchBar!
    var sortType: UISegmentedControl!
    
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
    
    internal func initializeSubviews() {
        self.resultsTableView = UITableView()
        self.searchBar = UISearchBar()
        self.sortType = UISegmentedControl(items: ["STARS", "FORKS", "UPDATED"])
    }
    
    internal func addSubviews() {
        self.addSubview(resultsTableView)
        self.addSubview(searchBar)
        self.addSubview(sortType)
    }
    
    internal func setupSubviews() {
        searchBar.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: ViewProperty.inset.none,
                                                                     left: ViewProperty.inset.none,
                                                                     bottom: ViewProperty.inset.none,
                                                                     right: ViewProperty.inset.none),
                                                  excludingEdge: .bottom)
        searchBar.barTintColor = ViewProperty.color.undabotBlue
        
        sortType.autoPinEdge(.top, to: .bottom, of: searchBar, withOffset: ViewProperty.inset.continous)
        sortType.autoPinEdge(toSuperviewEdge: .leading, withInset: ViewProperty.inset.large)
        sortType.autoPinEdge(toSuperviewEdge: .trailing, withInset: ViewProperty.inset.large)
        sortType.tintColor = ViewProperty.color.undabotBlue
        sortType.selectedSegmentIndex = 0
        
        
        
        resultsTableView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: ViewProperty.inset.none,
                                                                            left: ViewProperty.inset.none,
                                                                            bottom: ViewProperty.inset.none,
                                                                            right: ViewProperty.inset.none),
                                                         excludingEdge: .top)
        resultsTableView.autoPinEdge(.top, to: .bottom, of: sortType)
    }
    
}
