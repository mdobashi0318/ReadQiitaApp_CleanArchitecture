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
        tableView.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "ArticleCell")
        
        
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as? ArticleCell else {
            return UITableViewCell()
        }
        
        cell.setModel(article: presenter.model[indexPath.row])
        return cell
    }
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = presenter.model[indexPath.row]
        let vc = ArticleDetailsViewController()
        vc.initPresenter(.init(id: article.id, articleTitle: article.title, url: article.url))
        navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
