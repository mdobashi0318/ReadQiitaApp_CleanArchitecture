//
//  ArticleDetailsPresenter.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/06.
//

import Foundation


@MainActor
protocol ArticleDetailsPresenterProtocol {
    
    func fetchBookmark()
    
    func addBookmark(bookmark: Bookmark)
    
    func deleteBookmark(bookmark: Bookmark)
    
}


@MainActor
protocol ArticleDetailsPresenterDelegate: AnyObject {
    func fetchBookmark(isEmpty: Bool)
    
    func addSuccess()
    func addFailure(error: DBError)
    
    func deleteSuccess()
    func deleteFailure(error: DBError)
    
}


class ArticleDetailsPresenter: ArticleDetailsPresenterProtocol {

    private(set) var id: String = ""
    
    private(set) var articleTitle: String = ""
    
    private(set) var url: String = ""
    
    private var bookmark: Bookmark?
    
    private let useCase =  BookmarkUseCase()
    
    weak var delegate: ArticleDetailsPresenterDelegate!
    
    
    init(id: String, articleTitle: String, url: String) {
        self.id = id
        self.articleTitle = articleTitle
        self.url = url
    }
    
    
    func fetchBookmark() {
        guard let bookmark = useCase.fetchBookmark(id: id) else {
            delegate.fetchBookmark(isEmpty: true)
            return
        }
        
        delegate.fetchBookmark(isEmpty: false)
        self.bookmark = bookmark
    }
    
    
    func addBookmark(bookmark: Bookmark) {
        do {
             try useCase.addBookmark(bookmark)
            delegate.addSuccess()
        } catch {
            delegate.addFailure(error: error)
        }
        
    }
    
    func deleteBookmark(bookmark: Bookmark) {
        do {
            try useCase.deleteBookmark(bookmark)
            delegate.deleteSuccess()
        } catch {
            delegate.deleteFailure(error: error)
        }
        
    }
    
}
