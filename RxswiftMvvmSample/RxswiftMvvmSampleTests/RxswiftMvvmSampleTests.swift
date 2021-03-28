//
//  RxswiftMvvmSampleTests.swift
//  RxswiftMvvmSampleTests
//
//  Created by boko on 2021/02/04.
//  Copyright © 2021 boko. All rights reserved.
//

import XCTest
import RxSwift
import APIKit

@testable import RxswiftMvvmSample

class RxswiftMvvmSampleTests: XCTestCase {
    let disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func test_通信成功しパースができるかのテスト() {
        let imageDownloadExpectation: XCTestExpectation?
            = self.expectation(description: "url Illegal")
        let request = ShortenRequest(long_url: "https://dev.bitly.com")
        Session.rx_sendRequest(request: request)
            .subscribe {
                event in
                switch event {
                case .next(let a):
                    print(a)
                    imageDownloadExpectation?.fulfill()
                case .error( _):
                    XCTFail()
                default: break
                }
            }
            .disposed(by: disposeBag)
        
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_短縮化成功テスト() {
        let imageDownloadExpectation: XCTestExpectation?
            = self.expectation(description: "success")
        DataManager.getShortUrl(url: "https://dev.bitly.com") { (result) in
            switch result {
            case .success(let shorten):
                print(shorten)
                imageDownloadExpectation?.fulfill()
            case .notHttp(_ ):
                XCTFail()
            case .otherError:
                XCTFail()
            }
        }
        self.waitForExpectations(timeout: 2, handler: nil)
    }
    
    func test_短縮化失敗（URL不正）テスト() {
        let imageDownloadExpectation: XCTestExpectation?
            = self.expectation(description: "success")
        DataManager.getShortUrl(url: "hps://www.hatena.ne.jp/login?location=https%3A%2F%2Fblog.hatena.ne.jp%2Fpamyam%2Fpamyam.hatenablog.com%2Faccesslog") { (result) in
            switch result {
            case .success(let shorten):
                print(shorten)
                XCTFail()
            case .notHttp(_ ):
                imageDownloadExpectation?.fulfill()
            case .otherError:
                XCTFail()
            }
        }
        self.waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
