//
//  ShoppingSearchResultViewController.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/15/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ShoppingSearchResultViewController: BaseViewController<ShoppingSearchResultView> {
    
    let viewModel = ShoppingSearchResultViewModel()
    let disposeBag = DisposeBag()
    
    deinit {
        print("ShoppingSearchResultViewController Deinit")
    }
    
    override func configureRegister() {
        mainView.shoppingCollectionView.register(ShoppingCollectionViewCell.self, forCellWithReuseIdentifier: ShoppingCollectionViewCell.identifier)
    }
    
    override func bind() {
        // 이전 화면에서 넘겨받은 타이틀 보여주기
        let input = ShoppingSearchResultViewModel.Input(
            sortChanged: mainView.sortCollectionView.rx.itemSelected,
            prefetch: mainView.shoppingCollectionView.rx.prefetchItems
                .map { $0.last?.row ?? 0
                }
        )
        let output = viewModel.transform(input: input)
        
        // 타이틀
        output.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        // 쇼핑 아이템 컬렉션뷰
        output.shoppingItems
            .bind(to: mainView.shoppingCollectionView.rx.items(cellIdentifier: ShoppingCollectionViewCell.identifier, cellType: ShoppingCollectionViewCell.self)) { (row, element, cell) in
                cell.setData(element)
            }
            .disposed(by: disposeBag)
        
        // 총 검색 결과 개수
        output.totalCount
            .bind(to: mainView.resultCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        // 정렬 버튼 컬렉션뷰
        output.sortItems
            .bind(to: mainView.sortCollectionView.rx.items(cellIdentifier: SortCollectionViewCell.identifier, cellType: SortCollectionViewCell.self)) { [weak self] (item, element, cell) in
                if item == 0 {
                    self?.mainView.sortCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .bottom)
                }
                cell.sortLabel.text = element
                
            }
            .disposed(by: disposeBag)
        
        // 네트워크 통신 에러
        output.networkError
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, value in
                owner.showAlert(title: value,
                                message: "\(value)가 발생했습니다. 다시 시도해 주세요.",
                                button: "확인")
            }
            .disposed(by: disposeBag)
        
        // scrollToTop
        output.sorted
            .bind(with: self) { owner, _ in
                owner.mainView.shoppingCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }
            .disposed(by: disposeBag)
    }

}
