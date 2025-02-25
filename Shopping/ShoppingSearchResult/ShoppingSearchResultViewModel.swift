//
//  ShoppingSearchResultViewModel.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 2/6/25.
//

import Foundation

class ShoppingSearchResultViewModel {
    // 쿼리 파라미터
    var query = QueryParameters()
    
    // 로드
    let inputViewDidTrigger: Observable<Void?> = Observable(nil)

    // 정렬
    let inputNewSortParameter: Observable<String> = Observable("")
    
    // 네트워크 통신 이후, 보내줄 값
    let outputShoppingItems: Observable<[ShoppingItem]> = Observable([])
    // 타이틀 키워드
    let outputTitle: Observable<String> = Observable("")
    // 전체 개수
    let outputItemCount: Observable<String> = Observable("")
    
    init() {
        print(#function)
        inputViewDidTrigger.lazyBind { _ in
            
            //outputTitle의 클로저가 정의되기 전에 값이 변경되어 outputTitle.lazyBind로 설정하게 되면, 동작X
            // outputTitle.Bind로 설정하여 초기값도 실행되도록 하던가 아니면,
            // outputTitle.lazyBind를 통해 클로저를 초기화해놓고 난 다음에, inputViewDidTrigger의 밸류값을 변경하여 outputTitle의 값을 할당(변경) -> 클로저문 실행되도록 설정.
            self.outputTitle.value = self.query.searchKeyword
            self.getKeywordData()
        }
        
        inputNewSortParameter.lazyBind { sort in
            print("input sortParameter bind")
            self.query.sort = sort
            self.getKeywordData()
        }
    }
    
    private func getKeywordData() {
        print(#function)
//        print(inputQueryParameters.value)
        ShoppingNetworkManager.shared.getShoppingData(
            api: .ShoppingData(params: query),
            type: ShoppingData.self) { response in
                self.outputShoppingItems.value = response.items
                self.outputItemCount.value = NumberFormatterManager.shared.format(number: response.total)
            }
        
        
    }
    
}
