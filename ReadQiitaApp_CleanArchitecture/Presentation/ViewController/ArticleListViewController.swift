//
//  ArticleListViewController.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/01.
//

import UIKit
import RxSwift

class ArticleListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private let presenter: ArticleListPresenter = ArticleListPresenter()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        fetchArticles()
    }

    
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    private func fetchArticles() {
        presenter.fetchArticles()
            .subscribe(onNext: {
                self.tableView.reloadData()
                
            })
            .disposed(by: disposeBag)
    }
    
}



// MARK: - UITableViewDataSource, UITableViewDelegate

extension ArticleListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.model.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = presenter.model[indexPath.row].title
        
        return cell
    }
    
    
}

