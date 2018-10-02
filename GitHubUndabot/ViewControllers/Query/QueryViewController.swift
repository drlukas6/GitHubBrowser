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
import RxDataSources
import Action

class QueryViewController: UIViewController, BindableType {
    var viewModel: QueryViewModel!
    private var queryView: QueryView!
    private var disposeBag: DisposeBag!
    private var dataSource: RxTableViewSectionedAnimatedDataSource<RepositorySection>!
    
    private enum PropertyKeys {
        static let queryCellIdentifier = "queryCellIdentifier"
    }
    
    convenience init(viewModel: QueryViewModel) {
        self.init()
        self.viewModel = viewModel
        self.title = "Search Repositories"
        self.disposeBag = DisposeBag()
        queryView = QueryView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        configureDataSource()
        bindViewModel()
    }
    

    
    private func initialSetup() {
        self.view.backgroundColor = .white
        self.view.addSubview(queryView)
        queryView.autoPinEdgesToSuperviewEdges()
        setupTableView()
    }
    
    private func setupTableView() {
        queryView.resultsTableView.register(QueryResultTableViewCell.self,
                                            forCellReuseIdentifier: PropertyKeys.queryCellIdentifier)
        queryView.resultsTableView.rowHeight = 200
        queryView.resultsTableView.separatorStyle = .none
    }

    func bindViewModel() {
        let query = queryView
            .searchBar
            .rx
            .text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter {!$0.isEmpty}
        
        let sortType = queryView.sortType.rx.selectedSegmentIndex.asObservable()
            .map { index -> String in
                switch index {
                case 0:
                    return "stars"
                case 1:
                    return "forks"
                default:
                    return "updated"
                }
            }
        
        Observable
            .combineLatest(query, sortType) { (queryParam, sortParam) in
            self.viewModel.search(query: queryParam, sortType: sortParam)
            }
            .subscribe()
            .disposed(by: disposeBag)
        
        viewModel.sectionedResults
            .bind(to: queryView.resultsTableView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
    
        queryView
            .resultsTableView
            .rx
            .itemSelected
            .do(onNext: { [unowned self] indexPath in
                self.queryView.resultsTableView.deselectRow(at: indexPath, animated: true)
            })
            .map { [unowned self] indexPath in
                try! self.dataSource.model(at: indexPath) as! Repository
            }
            .subscribe(onNext: { [unowned self] repository in
                let repositoryViewModel = RepositoryViewModel(repository: repository)
                let repositoryScene = Scene.repositoryScene(repositoryViewModel)
                self.viewModel.transitionTo(scene: repositoryScene, context: self)
                })
            .disposed(by: disposeBag)
        
        viewModel
            .queryResults
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.queryView.searchBar.endEditing(true)
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func configureDataSource() {
        dataSource = RxTableViewSectionedAnimatedDataSource<RepositorySection>(
            configureCell: {
                [weak self] dataSource, tableView, indexPath, item in
                let cell  = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.queryCellIdentifier) as! QueryResultTableViewCell
                if let strongSelf = self {
                    let viewModel = QueryResultCellViewModel(repository: Variable<Repository>(item))
                    cell.setCell(with: viewModel)
                    
                    cell
                        .avatarImage
                        .rx
                        .tapGesture()
                        .throttle(0.5, scheduler: MainScheduler.instance)
                        .when(.recognized)
                        .subscribe(onNext: { _ in
                            cell.viewModel.getOwner()
                        })
                        .disposed(by: cell.disposeBag)
                    
                    cell
                        .viewModel
                        .repositoryOwner
                        .asObservable()
                        .observeOn(MainScheduler.instance)
                        .subscribe(onNext: { owner in
                            let userViewModel = UserViewModel(repositoryOwner: owner)
                            let userScene = Scene.userScene(userViewModel)
                            cell.viewModel.transitionTo(scene: userScene, context: strongSelf)
                        })
                        .disposed(by: cell.disposeBag)
                }
                return cell
            },
            titleForHeaderInSection: { dataSource, index in
                dataSource.sectionModels[index].model
            }
        )
    }
}

