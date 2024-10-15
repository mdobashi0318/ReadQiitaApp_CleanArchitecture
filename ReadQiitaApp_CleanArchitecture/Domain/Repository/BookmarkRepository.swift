//
//  BookmarkRepository.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/10.
//

import Foundation


protocol BookmarkRepositoryProtocol {
    func fetccBookmarks() -> [Bookmark]
    func fetchBookmark(id: String) -> Bookmark?
    func addBookmark(_ bookmark: Bookmark) throws(DBError)
    func deleteBookmark(_ bookmark: Bookmark) throws(DBError)
}


struct BookmarkRepository: BookmarkRepositoryProtocol {
    
    private let dataStore = BookmarkDataStore()
    
    func fetccBookmarks() -> [Bookmark] {
        dataStore.fetccBookmarks()
    }
    
    func fetchBookmark(id: String) -> Bookmark? {
        dataStore.fetccBookmark(id: id)
    }
    
    
    func addBookmark(_ bookmark: Bookmark) throws(DBError) {
        try dataStore.addBookmark(bookmark)
    }
    
    func deleteBookmark(_ bookmark: Bookmark) throws(DBError) {
        try dataStore.deleteBookmark(bookmark)
    }
    
    

}
