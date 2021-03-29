//
//  DataManager.swift
//  RxswiftMvvmSample
//
//  Created by yagi on 2021/03/08.
//  Copyright © 2021 boko. All rights reserved.
//

import Foundation
import RxSwift
import APIKit

class DataManager {
    static let disposeBag = DisposeBag()
    
    enum shortenResult {
        case success(_ res: Condensation)
        case otherError(_ message: String)
    }
    
    static func getShortUrl(url:String, completionHandler: ((_ result: shortenResult)->Void)?) {
        let shorten = ShortenRequest(long_url: url)
        Session.rx_sendRequest(request: shorten)
            .subscribe {
                event in
                var result: shortenResult
                switch event {
                case .next(let res):
                    result = .success(res)
                    completionHandler!(result)
                case .error(let mes):
                    result = .otherError(mes.localizedDescription)
                    completionHandler!(result)
                default: break
                }
            }.disposed(by: disposeBag)
    }
}
