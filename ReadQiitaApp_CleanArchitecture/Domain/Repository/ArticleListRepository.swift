//
//  ArticleListRepository.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/05.
//

import Foundation
import RxSwift


protocol ArticleListRepositoryProtocol {
    func fetchArticles(searchText: String) -> Observable<[Article]>
}


struct ArticleListRepository: ArticleListRepositoryProtocol {
    
    private let dataStore = ArticleDataStore()
    
    func fetchArticles(searchText: String) -> Observable<[Article]> {
        Observable.create { observable in
            dataStore.getArticleList(searchText: searchText, success: {
                observable.onNext($0)
                
            }, failure: { message, type in
                observable.onError(APIError(message: message, type: type))
                
            })
            
            return Disposables.create()
        }
    }
    
    
}
