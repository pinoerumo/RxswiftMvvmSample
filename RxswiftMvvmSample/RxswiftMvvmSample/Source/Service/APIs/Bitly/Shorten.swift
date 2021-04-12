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
    
    typealias Response = GetShortenResponse
    
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
    
    
    final class GetShortenResponse: Himotoki.Decodable {

        let condensation: Condensation
        
        init(_ e: Extractor) throws {
            let errorResponse = try BitlyError(e)
            
            guard let message = errorResponse.message else {
                do {
                    self.condensation = try Condensation.decode(e)
                    return
                } catch {
                    throw BitlyErrorCase.parseError
                }
            }
            throw BitlyErrorCase.bitlyAPIError(message: message)
        }
        
        static func decode(_ e: Extractor) throws -> GetShortenResponse {
            return try GetShortenResponse(e)
        }
    }
}



