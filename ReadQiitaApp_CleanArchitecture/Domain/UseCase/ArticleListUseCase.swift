//
//  ArticleListUseCase.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/05.
//

import Foundation
import RxSwift

protocol ArticleListUseCaseProtocol {
    func fetchArticles(searchText: String) -> Observable<[ArticleListRow]>
}


struct ArticleListUseCase: ArticleListUseCaseProtocol {
    
    private let repository = ArticleListRepository()
    
    func fetchArticles(searchText: String) -> Observable<[ArticleListRow]> {
        Observable.create { observable in
            _ = self.repository.fetchArticles(searchText: searchText)
                .subscribe(onNext: {
                    let translater = ArticleListTranslater()
                    observable.onNext(translater.translaterArticleRow(articles: $0))
                })
            
            return Disposables.create()
        }
    }
    
    
}
