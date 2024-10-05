//
//  ArticleListPresenter.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/05.
//

import Foundation
import RxSwift


protocol ArticleListPresenterProtocol {
    func fetchArticles() -> Observable<Void>
}


class ArticleListPresenter: ArticleListPresenterProtocol {
    
    private let useCase = ArticleListUseCase()
    
    private(set) var model: [Article] = []
    
    private let disposeBag = DisposeBag()
    
    func fetchArticles() -> Observable<Void> {
        Observable.create { observable in
            self.useCase.fetchArticles()
                .subscribe(onNext: {
                    self.model = $0
                    observable.onNext(Void())
                    
                })
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
        
    }
}
