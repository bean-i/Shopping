//
//  ShoppingMainView.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/16/25.
//

import UIKit
import SnapKit

final class ShoppingMainView: BaseView {

    let searchBar = UISearchBar()
    
    override func configureHierarchy() {
        addSubview(searchBar)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "브랜드, 상품, 프로필, 태그 등", attributes: [.foregroundColor : UIColor.lightGray.cgColor])
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .darkGray
        searchBar.searchTextField.leftView?.tintColor = .lightGray
        searchBar.searchTextField.textColor = .white
    }
    
}
