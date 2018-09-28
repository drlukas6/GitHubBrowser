//
//  QueryViewController.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 28/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import UIKit

class QueryViewController: UIViewController {
    private var queryView: QueryView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup() {
        self.view.backgroundColor = .white
        queryView = QueryView(frame: .zero)
        self.view.addSubview(queryView)
        queryView.autoPinEdgesToSuperviewEdges()
    }

}
