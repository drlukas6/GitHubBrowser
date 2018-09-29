//
//  QueryViewController.swift
//  GitHubUndabot
//
//  Created by Lukas Sestic on 28/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxSwift
import RxCocoa

class QueryViewController: UIViewController, BindableType {
    internal var viewModel: QueryViewModel!
    private var queryView: QueryView!
    private var disposeBag: DisposeBag!
    
    private var results: Variable<[Repository]>!

    convenience init(viewModel: QueryViewModel) {
        self.init()
        self.viewModel = viewModel
        self.results = Variable([])
        queryView = QueryView(frame: .zero)
        self.disposeBag = DisposeBag()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        bindViewModel()
    }
    
    func initialSetup() {
        self.view.backgroundColor = .white
        self.view.addSubview(queryView)
        queryView.autoPinEdgesToSuperviewEdges()
        
        queryView.resultsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "def")
    }

    func bindViewModel() {
        queryView.searchBar.rx.text.orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter {!$0.isEmpty}
            .subscribe(onNext: { query in
                self.viewModel.search(query: query)
            })
        
        viewModel.queryResults.asObservable()
            .bind(to: queryView.resultsTableView.rx.items) {
                (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "def") as! UITableViewCell
                cell.textLabel?.text = element.name
                return cell
        }
    }
}

