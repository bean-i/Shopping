//
//  ShoppingMainViewController.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/15/25.
//

import UIKit
import SnapKit

protocol NextScreen: AnyObject {
    func alert()
    func nextScreen(keyword: String)
}

final class ShoppingMainViewController: BaseViewController {
    
    var mainView = ShoppingMainView()
    let viewModel = ShoppingMainViewModel()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "도봉러의 쇼핑쇼핑"
    }
    
    override func configureDelegate() {
        mainView.searchBar.delegate = self
        viewModel.delegate = self
    }

}

extension ShoppingMainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchText.value = searchBar.text
    }
}

extension ShoppingMainViewController: NextScreen {
    
    func alert() {
        print(#function)
        showAlert(title: "두 글자 이상 입력", message: "검색어를 두 글자 이상 입력해 주세요.", button: "확인") {
            self.dismiss(animated: true)
        }
    }
    
    func nextScreen(keyword: String) {
        print(#function)
        let vc = ShoppingSearchResultViewController()
        vc.viewModel.query.searchKeyword = viewModel.inputSearchText.value!
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
