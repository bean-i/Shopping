//
//  ShoppingMainViewModel.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 2/6/25.
//

import Foundation

final class ShoppingMainViewModel {
    
    let inputSearchText: Observable<String?> = Observable(nil)
    
    weak var delegate: NextScreen?
    
    init() {
        inputSearchText.lazyBind { _ in
            self.searchButtonClicked()
        }
    }
    
    private func searchButtonClicked() {
        
        guard let searchText = inputSearchText.value else {
            print("searchBar 오류")
            return
        }
        
        if searchText.count >= 2 {
            delegate?.nextScreen(keyword: searchText)
        } else {
            delegate?.alert()
        }
        
    }
    
}
