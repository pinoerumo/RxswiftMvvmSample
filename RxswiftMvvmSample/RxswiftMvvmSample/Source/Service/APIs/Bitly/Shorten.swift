//
//  Shorten.swift
//  RxswiftMvvmSample
//
//  Created by boko on 2021/02/11.
//  Copyright © 2021 boko. All rights reserved.
//
import APIKit
import Himotoki

enum shortenError: Error {
    case urlError
}

struct ShortenRequest: BitlyRequest {
    
    var long_url: String
    
    var domain: String {
        return "bit.ly"
    }
    
    var group_guid: String {
        return Keys.groupId
    }
    
    typealias Response = Condensation
    
    var path: String {
        return "shorten"
    }

    var method: HTTPMethod {
        return .post
    }
    
    var headerFields: [String: String] {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(Keys.apiKey)"]
    }
    
    var parameters: Any? {
        return [
            "group_guid": group_guid,
            "domain": domain,
            "long_url": long_url
        ]
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> ShortenRequest.Response {
        return try decodeValue(object)
    }
}



