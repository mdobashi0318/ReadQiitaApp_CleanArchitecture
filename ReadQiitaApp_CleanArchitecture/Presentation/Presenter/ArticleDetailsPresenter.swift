//
//  ArticleDetailsPresenter.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/06.
//

import Foundation

struct ArticleDetailsPresenter {
    
    private(set) var id: String = ""
    
    private(set) var articleTitle: String = ""
    
    private(set) var url: String = ""
    
    init(id: String, articleTitle: String, url: String) {
        self.id = id
        self.articleTitle = articleTitle
        self.url = url
    }
    
}
