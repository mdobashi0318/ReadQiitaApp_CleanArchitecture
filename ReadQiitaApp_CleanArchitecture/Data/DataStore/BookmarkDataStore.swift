//
//  BookmarkDataStore.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/12.
//

import Foundation

protocol BookmarkDataStoreProtocol {
    func fetccBookmarks() -> [Bookmark]
    func addBookmark(_ bookmark: Bookmark) throws(DBError)
    func deleteBookmark(_ bookmark: Bookmark) throws(DBError)
}

struct BookmarkDataStore: BookmarkDataStoreProtocol {
    func fetccBookmarks() -> [Bookmark] {
        Bookmark.getAll()
    }
    
    func addBookmark(_ bookmark: Bookmark) throws(DBError) {
        try Bookmark.add(bookmark)
    }
    
    func deleteBookmark(_ bookmark: Bookmark) throws(DBError) {
        try Bookmark.delete(bookmark)
    }
    
    
}
