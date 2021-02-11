//
//  BitlyBase.swift
//  RxswiftMvvmSample
//
//  Created by boko on 2021/02/11.
//  Copyright © 2021 boko. All rights reserved.
//

import APIKit
import Himotoki

protocol BitlyRequest: Request {

}

extension BitlyRequest {
    var baseURL: URL {
        return URL(string: "https://api-ssl.bitly.com/v3/")!
    }

    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard (200..<300).contains(urlResponse.statusCode) else {
            throw ResponseError.unacceptableStatusCode(urlResponse.statusCode)
        }
        return object
    }
}

extension BitlyRequest where Response: Himotoki.Decodable {
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Self.Response {
        return try decodeValue(object)
    }
}
