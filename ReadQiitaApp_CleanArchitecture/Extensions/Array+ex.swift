//
//  Array+ex.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/06.
//

import Foundation

extension Array where Element == Tags {
    
    /// 配列のタグの名前を連結して一つの文字列として返す
    func joinedTagNames() -> String {
        var tagNames: [String] = []
        self.forEach {
            tagNames.append($0.name)
        }
        return tagNames.joined(separator: ",")
    }
    
}
