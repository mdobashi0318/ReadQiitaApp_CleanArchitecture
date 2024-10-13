//
//  BookmarkListViewController.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/13.
//

import UIKit

class BookmarkListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let presenter = BookmarkListPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "ブックマーク"
        presenter.delegate = self
        presenter.fetchAllBookmark()
        initTableView()
    }
    
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }


}




// MARK: - UITableViewDelegate, UITableViewDataSource

extension BookmarkListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = presenter.model[indexPath.row].title
        
        return cell
    }
    
    
}


// MARK: - BookmarkListViewController


extension BookmarkListViewController: BookmarkListPresenterDelegate {

    
    func successAllBookmark(_ bookmark: [Bookmark]) {
        tableView.reloadData()
    }
    
    
    func emptyData() {
        AlertManager.showAlert(self, type: .ok, message: "ブックマークがありません")
    }
    
    
}
