//
//  Condensation.swift
//  RxswiftMvvmSample
//
//  Created by boko on 2021/02/10.
//  Copyright © 2021 boko. All rights reserved.
//

import Foundation
import Himotoki

struct CondensationStruct: Himotoki.Decodable{
    let status_code: String
    let status_txt: Int
    let data: Condensation
    
    static func decode(_ e: Extractor) throws -> CondensationStruct {
            return try CondensationStruct(
                status_code: e <| "status_code",
                status_txt: e <| "status_txt",
                data: e <| "data"
            )
        }
}

struct Condensation: Himotoki.Decodable{

    let url: String
    
    let hash: String
    
    let global_hash: String
    
    let long_url: String
    
    let new_hash: Int
    
    static func decode(_ e: Extractor) throws -> Condensation {
        return try Condensation(
            url: e <| "url",
            hash: e <| "hash",
            global_hash: e <| "global_hash",
            long_url: e <| "long_url",
            new_hash: e <| "new_hash"
        )
    }
}
