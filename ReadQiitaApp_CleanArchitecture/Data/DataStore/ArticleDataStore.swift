//
//  ArticleDataStore.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/02.
//

import Foundation
import RxCocoa
import RxSwift

protocol ArticleDataStoreProtocol {
    func getArticleList(searchText: String, success: @escaping ([Article]) -> Void, failure: @escaping (String, ErrorResponse.ErrorType) -> Void)
}


struct ArticleDataStore: ArticleDataStoreProtocol {
    
    private let disposeBag = DisposeBag()
    
    func getArticleList(searchText: String, success: @escaping ([Article]) -> Void, failure: @escaping (String, ErrorResponse.ErrorType) -> Void) {
        let param = searchText.isEmpty ? nil : JSONEncoder.makeParameters(param: ItemQueryParameters(query: searchText))
        
        APIManager.request(request: "items", param: param)
            .subscribe(onNext: { result in
                success(result)
                
            }, onError: { error in
                guard let error = error as? APIError else { return }
                failure(error.message, error.type)
                
            })
            .disposed(by: disposeBag)
    }
    
    
    
}
