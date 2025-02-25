//
//  ShoppingSearchResultViewModel.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 2/6/25.
//

import Foundation
import RxSwift
import RxCocoa

final class ShoppingSearchResultViewModel: BaseViewModel {
    
    var title = BehaviorRelay(value: "")
    let disposeBag = DisposeBag()
    
    struct Input {
        let sortChanged: ControlEvent<IndexPath>
    }
    
    struct Output {
        let title: BehaviorRelay<String>
        let shoppingItems: PublishRelay<[ShoppingItem]>
        let totalCount: PublishRelay<String>
        let sortItems: BehaviorRelay<[String]> = BehaviorRelay(value: Sort.allCases.map { $0.rawValue })
    }
    
    func transform(input: Input) -> Output {
    
//        let items: BehaviorRelay<[ShoppingItem]> = BehaviorRelay(value: [])
        let items = PublishRelay<[ShoppingItem]>()
        
        let total = PublishRelay<String>()

        Observable.combineLatest(
            input.sortChanged,
            title
        )
        .map {
            QueryParameters(searchKeyword: $0.1, sort: Sort.allCases[$0.0.item].apiParameter)
        }
        .flatMap { ShoppingNetworkManager.shared.getShoppingData(api: .ShoppingData(params: $0), type: ShoppingData.self)
                .catch { error in
                    switch error as? APIError {
                    case .invalidURL:
                        print("invalidURL 에러 발생")
                    case .naverError(let code):
                        print("\(code) 에러 발생")
                    case .afError:
                        print("알 수 없는 에러 발생")
                    case .none:
                        break
                    }
                    let data = ShoppingData(total: 0, items: [])
                    return Single.just(data)
                }
        }
        .subscribe(with: self) { owner, value in
            items.accept(value.items)
            let count = NumberFormatterManager.shared.format(number: value.total)
            total.accept("\(count)개의 검색 결과")
        } onError: { owner, error in
            print("error", error)
        } onCompleted: { owner in
            print("onCompleted")
        } onDisposed: { owner in
            print("onDisposed")
        }
        .disposed(by: disposeBag)
        
        
        title
            .map { QueryParameters(searchKeyword: $0) }
            .flatMap { ShoppingNetworkManager.shared.getShoppingData(api: .ShoppingData(params: $0), type: ShoppingData.self)
                    .catch { error in
                        switch error as? APIError {
                        case .invalidURL:
                            print("invalidURL 에러 발생")
                        case .naverError(let code):
                            print("\(code) 에러 발생")
                        case .afError:
                            print("알라모파이어 자체 에러 발생")
                        case .none:
                            break
                        }
                        let data = ShoppingData(total: 0, items: [])
                        return Single.just(data)
                    }
            }
            .subscribe(with: self) { owner, value in
                items.accept(value.items)
                let count = NumberFormatterManager.shared.format(number: value.total)
                total.accept("\(count)개의 검색 결과")
            } onError: { owner, error in
                print("error", error)
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
            .disposed(by: disposeBag)

        return Output(
            title: title,
            shoppingItems: items,
            totalCount: total
        )
    }
    
}
