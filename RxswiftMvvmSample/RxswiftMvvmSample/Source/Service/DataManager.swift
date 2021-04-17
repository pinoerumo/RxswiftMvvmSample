//
//  Datamanager.swift
//  RxswiftMvvmSample
//
//  Created by yagi on 2021/04/18.
//  Copyright © 2021 boko. All rights reserved.
//

import Foundation
import RxSwift
import APIKit

class DataManager {
    let disposeBag = DisposeBag()
    
    static let shared = DataManager()
    
    enum shortenResult {
        case success(_ res: Condensation)
        case apiError(message: String)
        case otherError
    }
    
    func getShortUrl(url:String, completionHandler: ((_ result: shortenResult)->Void)?) {
        ConnectionManager.shared.getShortUrl(url: url, completionHandler:  { (result,error)  in
            if let error = error {
                switch error {
                case .parseError:
                    completionHandler?(.apiError(message: "error"))
                case .bitlyAPIError(message: let message):
                    completionHandler?(.apiError(message: message))
                case .otherError:
                    completionHandler?(.otherError)
                }
            }
            
            if let result = result {
                switch result {
                case .success(let res):
                    completionHandler?(.success(res))
                }
            }
            
            return
        })
        
    }
}
