//
//  Bookmark.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/02.
//

import Foundation
import RealmSwift


// MARK: - RLMBookmark

class RLMBookmark: Object {
    
    @Persisted(primaryKey: true) var id: String = ""
    
    @Persisted var title: String = ""
    
    @Persisted var url:  String = ""
    
    
    private static var realm: Realm? {
        var configuration: Realm.Configuration
        configuration = Realm.Configuration()
        configuration.schemaVersion = UInt64(1)
        return try? Realm(configuration: configuration)
    }
    
    
    static func getAll() -> [RLMBookmark] {
        guard let realm else {
            return []
        }
        
        var model: [RLMBookmark] = []
        realm.objects(RLMBookmark.self).forEach {
            model.append($0)
        }
        
        return model
        
    }
    
    
    static func find(id: String) -> RLMBookmark? {
        guard let realm else {
            return nil
        }
            
        return realm.objects(RLMBookmark.self).filter("id == '\(id)'").first
    }
    
    
    static func add(_ bookmark: RLMBookmark) throws(DBError) {
        do {
            guard let realm else {
                throw DBError(message: "初期化エラー")
            }
            
            try realm.write {
                realm.add(bookmark)
            }
        } catch {
            throw DBError(message: "追加エラー")
        }
    }
    
    
    static func delete(_ bookmark: RLMBookmark) throws(DBError) {
        do {
            guard let realm,
            let model = RLMBookmark.find(id: bookmark.id) else {
                throw DBError(message: "初期化エラー")
            }
             
            try realm.write {
                realm.delete(model)
            }
        } catch {
            throw DBError(message: "削除エラー")
        }
    }
    
    
    
    
}


// MARK: - Bookmark

struct Bookmark {
    
    let id: String
    
    let title: String
    
    let url: String
    
    
    static func getAll() -> [Bookmark] {
        let rlm = RLMBookmark.getAll()
        var model: [Bookmark] = []
        
        rlm.forEach {
            model.append(Bookmark(id: $0.id, title: $0.title, url: $0.url))
        }
        
        return model
    }
    
    static func find(_ id: String) -> Bookmark? {
        guard let rlm = RLMBookmark.find(id: id) else { return nil }
        
        return Bookmark(id: rlm.id, title: rlm.title, url: rlm.url)
    }
    
    
    static func add(_ bookmark :Bookmark) throws(DBError) {
        let rlm = RLMBookmark()
        rlm.id = bookmark.id
        rlm.title = bookmark.title
        rlm.url = bookmark.url
        
        do {
            try RLMBookmark.add(rlm)
        } catch {
            throw error
        }
    
    }
    
    
    static func delete(_ bookmark :Bookmark) throws(DBError) {
        let rlm = RLMBookmark()
        rlm.id = bookmark.id
        rlm.title = bookmark.title
        rlm.url = bookmark.url
        
        do {
            try RLMBookmark.delete(rlm)
        } catch {
            throw error
        }

    }
    
    
    
    static var mock: [Bookmark] {
        return [Bookmark(id: "1", title: "title1", url: ""),
                Bookmark(id: "2", title: "title2", url: ""),
                Bookmark(id: "3", title: "title3", url: ""),
                Bookmark(id: "4", title: "title4", url: ""),]
    }
    
}

