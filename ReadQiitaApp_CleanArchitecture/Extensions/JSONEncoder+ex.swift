//
//  JSONEncoder+ex.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/20.
//

import Foundation
import Alamofire


extension JSONEncoder {
    
    static func makeParameters<T: Codable>(param: T) -> Parameters? {
        let encode = JSONEncoder()
        
        guard let data = try? encode.encode(param),
              let dict  = try? JSONSerialization.jsonObject(with: data),
              let parameters = dict as? Parameters else {
            return nil
        }
        
        return parameters
    }
    
}
