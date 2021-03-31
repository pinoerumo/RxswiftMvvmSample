//
//  ShortenViewModels.swift
//  RxswiftMvvmSample
//
//  Created by yagi on 2021/03/30.
//  Copyright © 2021 boko. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol ShortenViewModelInputs {
    var convertTrigger: PublishSubject<Void> { get }
}

protocol ShortenViewModelOutputs {
    var convertString: Observable<String> { get }
}

protocol ShortenViewModelType {
    var inputs: ShortenViewModelInputs { get }
    var outputs: ShortenViewModelOutputs { get }
}

final class ShortenViewModel: ShortenViewModelType, ShortenViewModelInputs, ShortenViewModelOutputs {
    
    var inputs: ShortenViewModelInputs { return self }
    var outputs: ShortenViewModelOutputs { return self }
    
    // MARK: - Inputs
    let convertTrigger = PublishSubject<Void>()
    
    // MARK: - Outputs
    let convertString: Observable<String>
    
    private let disposeBag = DisposeBag()
    
    init(convert: String) {
        self.convertString = Observable.just(convert)
        
//        convertTrigger
//            .bind(to: searchAction.inputs)
//            .disposed(by: disposeBag)
    }
}
