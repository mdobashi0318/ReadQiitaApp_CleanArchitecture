//
//  ArticleListPresenter.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/05.
//

import Foundation
import RxSwift
import RxCocoa

protocol ArticleListPresenterProtocol {
    func fetchArticles() -> Observable<Void>
}


class ArticleListPresenter: ArticleListPresenterProtocol {
    
    private let useCase = ArticleListUseCase()
    
    private(set) var model: [ArticleListRow] = []
    
    private let disposeBag = DisposeBag()
    
    let searchText: BehaviorRelay<String> = .init(value: "")
    
    func fetchArticles() -> Observable<Void> {
        Observable.create { observable in
            self.useCase.fetchArticles(searchText: self.searchText.value)
                .subscribe(onNext: {
                    self.model = $0
                    observable.onNext(Void())
                    
                }, onError: {
                    observable.onError($0)
                    
                })
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
        
    }
}
