//
//  BitlyBase.swift
//  RxswiftMvvmSample
//
//  Created by boko on 2021/02/11.
//  Copyright © 2021 boko. All rights reserved.
//

import APIKit
import Himotoki

/// 共通API エラー
enum BitlyErrorCase: Error {
    //APIレスポンスエラー
    case parseError
    //BitlyAPIでエラーがあった際のエラー
    case bitlyAPIError(message: String)
    //未ハンドリングエラー
    case otherError
}

protocol BitlyRequest: Request {

}

extension BitlyRequest {
    var baseURL: URL {
        return URL(string: "https://api-ssl.bitly.com/v4/")!
    }
    
    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard (200..<500).contains(urlResponse.statusCode) else {
            throw ResponseError.unacceptableStatusCode(urlResponse.statusCode)
        }
        return object
    }
}

extension BitlyRequest where Response: Himotoki.Decodable {
    
    var dataParser: DataParser {
        return JSONDataParser(readingOptions: [])
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Self.Response {
        return try decodeValue(object)
    }
}

final class BitlyError: Himotoki.Decodable{
    // エラーレスポンス内にあるMessageがあるかどうかでエラー判定を行なっている
    let message: String?
    
    init(_ e: Extractor) throws {
        do {
            message = try e <|? "message"
        } catch {
            //optional型でパースしているためThrowされることがない
            throw BitlyErrorCase.parseError
        }
    }
    static func decode(_ e: Extractor) throws -> BitlyError {
        return try BitlyError(e)
    }
}
