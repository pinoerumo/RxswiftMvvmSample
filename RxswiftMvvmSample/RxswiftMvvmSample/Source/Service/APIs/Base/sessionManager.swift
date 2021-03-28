//
//  sessionManager.swift
//  RxswiftMvvmSample
//
//  Created by boko on 2021/02/11.
//  Copyright © 2021 boko. All rights reserved.
//

import RxSwift
import APIKit

extension Session {
    func rx_sendRequest<T: Request>(request: T) -> Observable<T.Response> {
        return Observable.create { observer in
            let task = self.send(request) { result in
                switch result {
                case .success(let res):
                    observer.on(.next(res))
                    observer.on(.completed)
                case .failure(let err):
                    observer.onError(err)
                }
            }
            return Disposables.create {
                task?.cancel()
            }
        }
    }

    class func rx_sendRequest<T: Request>(request: T) -> Observable<T.Response> {
        return shared.rx_sendRequest(request: request)
    }
}


