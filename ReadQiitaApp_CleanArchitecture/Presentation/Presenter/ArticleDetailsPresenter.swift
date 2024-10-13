//
//  ArticleDetailsPresenter.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/06.
//

import Foundation


protocol ArticleDetailsPresenterProtocol {
    
    func addBookmark(bookmark: Bookmark) -> Bool
    
    func deleteBookmark(bookmark: Bookmark) -> Bool
    
}


struct ArticleDetailsPresenter: ArticleDetailsPresenterProtocol {

    private(set) var id: String = ""
    
    private(set) var articleTitle: String = ""
    
    private(set) var url: String = ""
    
    
    init(id: String, articleTitle: String, url: String) {
        self.id = id
        self.articleTitle = articleTitle
        self.url = url
    }
    
    func addBookmark(bookmark: Bookmark) -> Bool {
        true
    }
    
    func deleteBookmark(bookmark: Bookmark) -> Bool {
        true
    }
    
}
