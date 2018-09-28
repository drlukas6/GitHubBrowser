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
    }
    
    internal func addSubviews() {
        self.addSubview(resultsTableView)
        self.addSubview(searchBar)
    }
    
    internal func setupSubviews() {
        searchBar.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: ViewProperties.noInset,
                                                                     left: ViewProperties.noInset,
                                                                     bottom: ViewProperties.noInset,
                                                                     right: ViewProperties.noInset),
                                                  excludingEdge: .bottom)
        
        resultsTableView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: ViewProperties.noInset,
                                                                            left: ViewProperties.noInset,
                                                                            bottom: ViewProperties.noInset,
                                                                            right: ViewProperties.noInset),
                                                         excludingEdge: .top)
        resultsTableView.autoPinEdge(.top, to: .bottom, of: searchBar)
    }
    
}
