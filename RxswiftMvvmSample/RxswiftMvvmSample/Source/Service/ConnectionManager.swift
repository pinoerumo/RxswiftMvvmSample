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

class ConnectionManager {
    let disposeBag = DisposeBag()
    
    static let shared = ConnectionManager()
    
    enum ShortenSuccessResult {
        case success(_ res: Condensation)
    }
    
    func getShortUrl(url:String, completionHandler: ((_ result: ShortenSuccessResult?,BitlyErrorCase?)->Void)?) {
        let shorten = ShortenRequest(long_url: url)
        Session.rx_sendRequest(request: shorten)
            .subscribe(onNext: { (response) in
                completionHandler!(.success(response.condensation), nil)
            }, onError: { (error) in
                completionHandler!(nil, self.convertError(error: error))
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
    }
    
    func convertError(error : Error?) -> BitlyErrorCase {
        
        let returnError: BitlyErrorCase
        
        if let sessionError = error as? SessionTaskError {
            
            switch sessionError {
            case .connectionError(_):
                returnError = .otherError
            case .requestError(_):
                returnError = .otherError
            case .responseError(let subError):
                if let bitlyError = subError as? BitlyErrorCase {
                    switch bitlyError {
                    
                    case .bitlyAPIError(message: let mes):
                        returnError = .bitlyAPIError(message: mes)
                    case .parseError:
                        returnError = .parseError
                    default:
                        returnError = .otherError
                    }
                } else {
                    returnError = .otherError
                }
            }
        } else {
            returnError = .otherError
        }
        return returnError
    }
}
