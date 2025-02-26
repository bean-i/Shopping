//
//  ShoppingMainViewModel.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 2/6/25.
//

import Foundation
import RxSwift
import RxCocoa

final class ShoppingMainViewModel: BaseViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let searchText: Observable<String>
    }
    
    struct Output {
        let title: Observable<String> = Observable.just("도봉러의 쇼핑쇼핑")
        let searchFail: PublishSubject<Bool>
        let searchSuccess: PublishSubject<String>
        let barButton = Observable.just("plus")
    }
    
    func transform(input: Input) -> Output {
        
        let searchFail = PublishSubject<Bool>()
        let searchSuccess = PublishSubject<String>()
        
        
        input.searchText
//            .map { $0.count >= 2 }
            .subscribe(with: self) { owner, value in
//                if bool {
//                    searchSuccess.onNext(true)
//                } else {
//                    searchFail.onNext(true)
//                }
                if value.count >= 2 {
                    searchSuccess.onNext(value)
                } else {
                    searchFail.onNext(true)
                }
            } onDisposed: { owner in
                print("input.searchText onDisposed")
            }
            .disposed(by: disposeBag)
        
        return Output(
            searchFail: searchFail,
            searchSuccess: searchSuccess
        )
    }
}
