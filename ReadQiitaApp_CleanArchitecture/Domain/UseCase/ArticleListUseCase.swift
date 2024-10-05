//
//  ArticleListUseCase.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/05.
//

import Foundation
import RxSwift

protocol ArticleListUseCaseProtocol {
    func fetchArticles() -> Observable<[Article]>
}


struct ArticleListUseCase: ArticleListUseCaseProtocol {
    
    private let repository = ArticleListRepository()
    
    func fetchArticles() -> Observable<[Article]> {
        Observable.create { observable in
            _ = self.repository.fetchArticles()
                .subscribe(onNext: { observable.onNext($0) })
            
            return Disposables.create()
        }
    }
    
    
}
