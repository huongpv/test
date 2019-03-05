//
//  Snapshot+Ex.swift
//  Test
//
//  Created by huongpv on 3/5/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import Foundation
import Firebase

extension QueryDocumentSnapshot {
    func decoded<T: Decodable>() throws -> T {
        let jsonData = try JSONSerialization.data(withJSONObject: data(), options: [])
        let object: T = try JSONDecoder().decode(T.self, from: jsonData)

        return object
    }
}

extension QuerySnapshot {
    func decoded<T: Decodable>() throws -> [T] {
        let objects: [T] = try documents.map({ try $0.decoded() })
        
        return objects
    }
}
