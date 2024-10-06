//
//  ArticleListRow.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/06.
//

import Foundation

protocol ArticleListTranslaterProtocol {
    func translaterArticleRow(articles: [Article]) -> [ArticleListRow]
}

struct ArticleListTranslater: ArticleListTranslaterProtocol {
    func translaterArticleRow(articles: [Article]) -> [ArticleListRow] {
        var rows: [ArticleListRow] = []
        
        articles.forEach {
            rows.append(ArticleListRow(id: $0.user.id,
                                       useName: $0.user.name,
                                       date: Date.created_at_format($0.created_at),
                                       title: $0.title,
                                       url: $0.url,
                                       tags: $0.tags.joinedTagNames(),
                                       likes: "\($0.likes_count)",
                                       organization: $0.user.organization ?? ""
                                      )
            )
        }
        
        
        return rows
    }
    
    
    
    
    
}


struct ArticleListRow {
    var id: String
    var useName: String
    var date: String
    var title: String
    var url: String
    var tags: String
    var likes: String
    var organization: String
    
    
    init(id: String, useName: String, date: String, title: String, url: String, tags: String, likes: String, organization: String) {
        self.id = id
        self.useName = useName
        self.date = date
        self.title = title
        self.url = url
        self.tags = tags
        self.likes = likes
        self.organization = organization
    }
}
