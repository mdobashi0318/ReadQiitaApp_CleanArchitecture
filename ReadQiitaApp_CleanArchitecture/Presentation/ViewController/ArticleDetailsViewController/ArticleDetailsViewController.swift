//
//  ArticleDetailsViewController.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/05.
//

import UIKit
import WebKit

class ArticleDetailsViewController: UIViewController {
    
    @IBOutlet private weak var webView: WKWebView!
    
    private var presenter: ArticleDetailsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.title = presenter.articleTitle
        webView.navigationDelegate = self
        loadWebView()
        
    }
    
    
    func initPresenter(_ presenter: ArticleDetailsPresenter) {
        self.presenter = presenter
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
