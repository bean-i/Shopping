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
    
    var currentPage = 1
    let paginationData = 30
    
    struct Input {
        let sortChanged: ControlEvent<IndexPath>
        let prefetch: Observable<Int>
    }
    
    struct Output {
        let title: BehaviorRelay<String>
        let shoppingItems: BehaviorRelay<[ShoppingItem]>
        let totalCount: PublishRelay<String>
        let sortItems: BehaviorRelay<[String]> = BehaviorRelay(value: Sort.allCases.map { $0.rawValue })
        let networkError: PublishRelay<String>
        let sorted: PublishRelay<Void>
    }
    
    func transform(input: Input) -> Output {
    
//        let items: BehaviorRelay<[ShoppingItem]> = BehaviorRelay(value: [])
        let items = BehaviorRelay<[ShoppingItem]>(value: [])
        
        let total = PublishRelay<String>()
        let networkError = PublishRelay<String>()
        let sorted = PublishRelay<Void>()

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
                        networkError.accept("invalidURL 에러")
                    case .naverError(let code):
                        print("\(code) 에러 발생")
                        networkError.accept("\(code) 에러")
                    case .afError:
                        print("통신 에러")
                        networkError.accept("AF 통신 에러")
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
            owner.currentPage = 1
            sorted.accept(())
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
                            networkError.accept("invalidURL 에러")
                        case .naverError(let code):
                            print("\(code) 에러 발생")
                            networkError.accept("\(code) 에러")
                        case .afError:
                            print("통신 에러")
                            networkError.accept("AF 통신 에러")
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
        
        Observable.combineLatest(
            items,
            input.prefetch
        )
        .filter {
            print("prefetch중")
            let dataCount = $0.0.count
            let currentIndex = $0.1
            print(dataCount, currentIndex)
            if dataCount - 5 < currentIndex {
                return true
            } else {
                return false
            }
        }
        .withUnretained(self)
        .map { _ in
            self.currentPage += 1
            return QueryParameters(
                searchKeyword: self.title.value,
                display: self.paginationData,
                start: self.currentPage
            )
        }
        .flatMapFirst { ShoppingNetworkManager.shared.getShoppingData(api: .ShoppingData(params: $0), type: ShoppingData.self)
                .catch { error in
                    switch error as? APIError {
                    case .invalidURL:
                        print("invalidURL 에러 발생")
                        networkError.accept("invalidURL 에러")
                    case .naverError(let code):
                        print("\(code) 에러 발생")
                        networkError.accept("\(code) 에러")
                    case .afError:
                        print("통신 에러")
                        networkError.accept("AF 통신 에러")
                    case .none:
                        break
                    }
                    let data = ShoppingData(total: 0, items: [])
                    return Single.just(data)
                }
        }
        .subscribe(with: self) { owner, value in
            items.accept(items.value + value.items)
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
            totalCount: total,
            networkError: networkError,
            sorted: sorted
        )
    }
    
}
