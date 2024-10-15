//
//  ArticleDetailsViewController.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/05.
//

import UIKit
import WebKit
import RxSwift

class ArticleDetailsViewController: UIViewController {
    
    @IBOutlet private weak var webView: WKWebView!
    
    private var presenter: ArticleDetailsPresenter!
    
    private let disposeBag = DisposeBag()
    
    private var mode: Mode = .add
    
    private var addBarButtonItem: UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        barButtonItem.rx
            .tap
            .subscribe(onNext: {
                self.presenter.addBookmark(bookmark: Bookmark(id: self.presenter.id,
                                                              title: self.presenter.articleTitle,
                                                              url: self.presenter.url)
                )
            })
            .disposed(by: disposeBag)
        
        return barButtonItem
    }
    
    
    private var deleteBarButtonItem: UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: nil, action: nil)
        barButtonItem.rx
            .tap
            .subscribe(onNext: {
                self.presenter.deleteBookmark(bookmark: Bookmark(id: self.presenter.id,
                                                              title: self.presenter.articleTitle,
                                                              url: self.presenter.url)
                )
            })
            .disposed(by: disposeBag)
        
        return barButtonItem
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationItem()
        presenter.delegate = self
        presenter.fetchBookmark()
        webView.navigationDelegate = self
        loadWebView()
        
    }
    
    
    func initPresenter(_ presenter: ArticleDetailsPresenter) {
        self.presenter = presenter
    }
    
    
    private func initNavigationItem() {
        navigationController?.title = presenter.articleTitle
        navigationItem.rightBarButtonItem = mode == .add ? addBarButtonItem : deleteBarButtonItem
    }
    
    
    private func loadWebView() {
        guard let url = URL(string: presenter.url) else {
            AlertManager.showAlert(self, type: .ok, message: "記事の表示に失敗しましました。", didTapPositiveButton: { _ in
                self.navigationController?.popViewController(animated: true)
            })
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    
    private func modeChange(mode: Mode) {
        self.mode = mode
        navigationItem.rightBarButtonItem = mode == .add ? addBarButtonItem : deleteBarButtonItem
    }
    
    
    private enum Mode {
        case add
        case delete
    }
    
    
}



// MARK: - WKNavigationDelegate

extension ArticleDetailsViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        Indicator.show(view)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Indicator.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError: Error) {
        Indicator.dismiss()
    }
    
    
}


// MARK: - ArticleDetailsPresenterDelegate

extension ArticleDetailsViewController: ArticleDetailsPresenterDelegate {
    
    func fetchBookmark(isEmpty: Bool) {
        modeChange(mode: isEmpty ? .add : .delete)
    }
    
    func addSuccess() {
        modeChange(mode: .delete)
    }
    
    func addFailure(error: DBError) {
        AlertManager.showAlert(self, type: .ok, message: error.message)
    }
    
    func deleteSuccess() {
        modeChange(mode: .add)
    }
    
    func deleteFailure(error: DBError) {
        AlertManager.showAlert(self, type: .ok, message: error.message)
    }
    
}
