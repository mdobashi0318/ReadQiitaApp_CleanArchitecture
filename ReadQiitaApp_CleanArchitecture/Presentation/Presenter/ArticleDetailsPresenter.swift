//
//  ArticleDetailsPresenter.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/06.
//

import Foundation


// MARK: - ArticleDetailsPresenterProtocol

@MainActor
protocol ArticleDetailsPresenterProtocol {
    
    func fetchBookmark()
    
    func addBookmark()
    
    func deleteBookmark()
    
}


// MARK: - ArticleDetailsPresenterDelegate

@MainActor
protocol ArticleDetailsPresenterDelegate: AnyObject {
    func fetchBookmark(isEmpty: Bool)
    
    func addSuccess()
    func addFailure(error: DBError)
    
    func deleteSuccess()
    func deleteFailure(error: DBError)
    
}


// MARK: - ArticleDetailsPresenter

class ArticleDetailsPresenter {

    let id: String
    
    let articleTitle: String
    
    let url: String
    
    private var bookmark: Bookmark?
    
    private let useCase =  BookmarkUseCase()
    
    weak var delegate: ArticleDetailsPresenterDelegate!
    
    
    init(id: String, articleTitle: String, url: String) {
        self.id = id
        self.articleTitle = articleTitle
        self.url = url
    }
    
    
}



// MARK: - ArticleDetailsPresenterProtocol

extension ArticleDetailsPresenter: ArticleDetailsPresenterProtocol {
    
    func fetchBookmark() {
        guard let bookmark = useCase.fetchBookmark(id: id) else {
            delegate.fetchBookmark(isEmpty: true)
            return
        }
        
        delegate.fetchBookmark(isEmpty: false)
        self.bookmark = bookmark
    }
    
    
    func addBookmark() {
        do {
             try useCase.addBookmark(Bookmark(id: id, title: articleTitle, url: url))
            delegate.addSuccess()
            
        } catch {
            delegate.addFailure(error: error)
        }
        
    }
    
    
    func deleteBookmark() {
        do {
            try useCase.deleteBookmark(Bookmark(id: id, title: articleTitle, url: url))
            delegate.deleteSuccess()
            
        } catch {
            delegate.deleteFailure(error: error)
        }
        
    }
}
