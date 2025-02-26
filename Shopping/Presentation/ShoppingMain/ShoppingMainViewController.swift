//
//  ShoppingMainViewController.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/15/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ShoppingMainViewController: BaseViewController<ShoppingMainView> {
    
    let viewModel = ShoppingMainViewModel()
    let disposeBag = DisposeBag()
    
    override func bind() {
        let input = ShoppingMainViewModel.Input(searchText: mainView.searchBar.rx.searchButtonClicked
            .withLatestFrom(mainView.searchBar.searchTextField.rx.text.orEmpty))
        let output = viewModel.transform(input: input)
        
        // 타이틀
        output.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)

        // alert
        output.searchFail
            .subscribe(with: self) { owner, _ in
                owner.showAlert(title: "두 글자 이상 입력",
                                message: "검색어를 두 글자 이상 입력해 주세요.",
                                button: "확인")
            } onDisposed: { owner in
                print("output.searchFail onDisposed")
            }
            .disposed(by: disposeBag)
        
        // 화면 전환
        output.searchSuccess
            .subscribe(with: self) { owner, value in
                let vc = ShoppingSearchResultViewController()
                vc.viewModel.title.accept(value)
                owner.navigationController?.pushViewController(vc, animated: true)
            } onDisposed: { owner in
                print("output.searchSuccess onDisposed")
            }
            .disposed(by: disposeBag)
        
        // 네비게이션 버튼
        output.barButton
            .map {
                UIBarButtonItem(image: UIImage(systemName: $0), style: .plain, target: nil, action: nil)
            }
            .bind(to: navigationItem.rx.rightBarButtonItem)
            .disposed(by: disposeBag)
        
        // 네비게이션 버튼 -> 화면 전환
        navigationItem.rightBarButtonItem?.rx.tap
            .subscribe(with: self) { owner, _ in
                let vc = WishListViewController()
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
    }
}
