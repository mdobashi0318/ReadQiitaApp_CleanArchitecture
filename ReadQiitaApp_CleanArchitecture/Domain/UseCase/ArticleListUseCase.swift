//
//  ArticleListUseCase.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/05.
//

import Foundation
import RxSwift

protocol ArticleListUseCaseProtocol {
    func fetchArticles() -> Observable<[ArticleListRow]>
}


struct ArticleListUseCase: ArticleListUseCaseProtocol {
    
    private let repository = ArticleListRepository()
    
    func fetchArticles() -> Observable<[ArticleListRow]> {
        Observable.create { observable in
            _ = self.repository.fetchArticles()
                .subscribe(onNext: {
                    let translater = ArticleListTranslater()
                    observable.onNext(translater.translaterArticleRow(articles: $0))
                })
            
            return Disposables.create()
        }
    }
    
    
}
