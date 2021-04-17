//
//  APITests.swift
//  RxswiftMvvmSample
//
//  Created by yagi on 2021/04/18.
//  Copyright © 2021 boko. All rights reserved.
//

import XCTest
import RxSwift
import APIKit

@testable import RxswiftMvvmSample

class APITests: XCTestCase {
    let disposeBag = DisposeBag()
    
    func test_短縮化成功テスト() {
        let imageDownloadExpectation: XCTestExpectation?
            = self.expectation(description: "success")
        DataManager.shared.getShortUrl(url: "https://dev.bitly.com") { (result) in
            switch result {
            case .success(let shorten):
                print("--------response---------")
                print(shorten)
                print("--------response---------")
                imageDownloadExpectation?.fulfill()
            case .apiError(_):
                XCTFail()
            case .otherError:
                XCTFail()
            }
        }
        self.waitForExpectations(timeout: 2, handler: nil)
    }
    
    func test_短縮化失敗（URL不正）テスト() {
        let imageDownloadExpectation: XCTestExpectation?
            = self.expectation(description: "Fail")
        DataManager.shared.getShortUrl(url: "hps://dev.bitly.com") { (result)  in
            switch result {
            case .success(_):
                XCTFail()
            case .apiError(message:let mes):
                print(mes)
                imageDownloadExpectation?.fulfill()
            case .otherError:
                XCTFail()
            }
        }
        self.waitForExpectations(timeout: 2, handler: nil)
    }
}
