//
//  ArticleListRepository.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/05.
//

import Foundation
import RxSwift


protocol ArticleListRepositoryProtocol {
    func fetchArticles() -> Observable<[Article]>
}


struct ArticleListRepository: ArticleListRepositoryProtocol {
    
    private let dataStore = ArticleDataStore()
    
    func fetchArticles() -> Observable<[Article]> {
        Observable.create { observable in
            dataStore.getArticleList(success: {
                observable.onNext($0)
                
            }, failure: { _, _ in
                
            })
            
            return Disposables.create()
        }
    }
    
    
}
