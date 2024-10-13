//
//  BookmarkUseCase.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/10.
//

import Foundation


protocol BookmarkUseCaseProtocol {
    func fetchAllBookmark() -> [Bookmark]
    func addBookmark(_ bookmark: Bookmark) throws(DBError)
    func deleteBookmark(_ bookmark: Bookmark) throws(DBError)
}

struct BookmarkUseCase: BookmarkUseCaseProtocol {
    
    private let repository = BookmarkRepository()
    
    func fetchAllBookmark() -> [Bookmark] {
        repository.fetccBookmarks()
    }
    
    func addBookmark(_ bookmark: Bookmark) throws(DBError) {
        try repository.addBookmark(bookmark)
    }
    
    func deleteBookmark(_ bookmark: Bookmark) throws(DBError) {
        try repository.deleteBookmark(bookmark)
    }
    
    
    
    
    
    
}
