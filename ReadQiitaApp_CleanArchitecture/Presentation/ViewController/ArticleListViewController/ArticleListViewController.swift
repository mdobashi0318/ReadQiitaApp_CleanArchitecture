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
        
        initNavigationItem()
        initTableView()
        fetchArticles()
    }

    
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "ArticleCell")
        
        // リフレッシュコントロール
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                guard let self else {
                    refreshControl.endRefreshing()
                    return
                }
                self.fetchArticles()
                refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
    }
    
    
    private func initNavigationItem() {
        navigationItem.title = "ReadQiitaApp"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem?.rx
            .tap
            .subscribe(onNext: {
                let navi = UINavigationController(rootViewController: BookmarkListViewController())
                navi.modalPresentationStyle = .fullScreen
                self.navigationController?.present(navi, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    
    private func fetchArticles() {
        Indicator.show(self.view)
        presenter.fetchArticles()
            .subscribe(onNext: {
                self.tableView.reloadData()
                Indicator.dismiss()
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

