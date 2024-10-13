//
//  BookmarkListPresenter.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/13.
//

import Foundation
import RxSwift

@MainActor
protocol BookmarkListPresenterDelegate: AnyObject {
    func successAllBookmark(_ bookmark:[Bookmark])
    func emptyData()
}

@MainActor
protocol BookmarkListPresenterProtocol {
    func fetchAllBookmark()
}


class BookmarkListPresenter: BookmarkListPresenterProtocol {

    private(set) var model: [Bookmark] = []
    
    weak var delegate: BookmarkListPresenterDelegate!
    
    private let useCase = BookmarkUseCase()

    
    func fetchAllBookmark() {
//        model = useCase.fetchAllBookmark()
        model = Bookmark.mock
        if model.isEmpty {
            delegate.emptyData()
        } else {
            delegate.successAllBookmark(model)
        }
        
    }
    
}
