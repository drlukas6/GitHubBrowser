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
import RxGesture

class QueryViewController: UIViewController, BindableType {
    internal var viewModel: QueryViewModel!
    private var queryView: QueryView!
    private var disposeBag: DisposeBag!
    
    private enum PropertyKeys {
        static let queryCellIdentifier = "queryCellIdentifier"
    }
    
    convenience init(viewModel: QueryViewModel) {
        self.init()
        self.viewModel = viewModel
        queryView = QueryView(frame: .zero)
        self.disposeBag = DisposeBag()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
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
        let query = queryView.searchBar.rx.text.orEmpty
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
        
        Observable.combineLatest(query, sortType) { (queryParam, sortParam) in
            self.viewModel.search(query: queryParam, sortType: sortParam)
        }.subscribe().disposed(by: disposeBag)
        
        viewModel.queryResults.asObservable()
            .share(replay: 1, scope: .whileConnected)
            .bind(to: queryView.resultsTableView.rx.items) {
                (tableView, row, element) in
                guard let cell  = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.queryCellIdentifier) as? QueryResultTableViewCell else {
                    fatalError()
                }
                cell.viewModel = self.viewModel.viewModelForCell(at: row)
                cell.configureCell(with: cell.viewModel.repository.value)

                cell.avatarImage.rx.tapGesture()
                    .throttle(0.5, scheduler: MainScheduler.instance)
                    .when(.recognized)
                    .subscribe(onNext: { _ in
                        cell.viewModel.getUser()
                    })
                    .disposed(by: self.disposeBag)
                
                cell.viewModel.repositoryOwner.asObservable()
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { owner in
                        let userViewModel = UserViewModel(repositoryOwner: owner)
                        let userScene = Scene.userScene(userViewModel)
                        cell.viewModel.transitionTo(scene: userScene, context: self)
                    })
                    .disposed(by: self.disposeBag)
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.queryResults.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.queryView.searchBar.endEditing(true)
            })
            .disposed(by: disposeBag)
        
        queryView.resultsTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let strongSelf = self else { return }
                strongSelf.queryView.resultsTableView.deselectRow(at: indexPath, animated: true)
                let repositoryViewModel = RepositoryViewModel(repository: strongSelf.viewModel.queryResults.value[indexPath.row])
                let repositoryScene = Scene.repositoryScene(repositoryViewModel)
                strongSelf.viewModel.transitionTo(scene: repositoryScene, context: strongSelf)
                
            })
            .disposed(by: disposeBag)
        
    }
}

