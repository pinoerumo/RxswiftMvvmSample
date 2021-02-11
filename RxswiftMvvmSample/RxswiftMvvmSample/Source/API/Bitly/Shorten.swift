//
//  Shorten.swift
//  RxswiftMvvmSample
//
//  Created by boko on 2021/02/11.
//  Copyright © 2021 boko. All rights reserved.
//
import APIKit
import Himotoki

struct ShortenRequest: BitlyRequest {
    
    var access_token: String
    var longUrl: String
    
    typealias Response = [CondensationStruct]
    
    var path: String {
        return "shorten"
    }

    var method: HTTPMethod {
        return .get
    }


    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> ShortenRequest.Response {
        return try decodeArray(object)
    }
}

