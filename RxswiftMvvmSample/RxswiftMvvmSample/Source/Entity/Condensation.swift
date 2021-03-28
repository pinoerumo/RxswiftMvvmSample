//
//  Condensation.swift
//  RxswiftMvvmSample
//
//  Created by boko on 2021/02/10.
//  Copyright © 2021 boko. All rights reserved.
//

import Foundation
import Himotoki

struct Condensation: Himotoki.Decodable{
    let link: String
    let createdAt: String

    
    static func decode(_ e: Extractor) throws -> Condensation {
            return try Condensation(
                link: e <| "link",
                createdAt: e <| "created_at"
            )
        }
}
