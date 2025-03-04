//
//  LikeListView.swift
//  Shopping
//
//  Created by 이빈 on 3/4/25.
//

import UIKit
import SnapKit

final class LikeListView: BaseView {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()

    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        backgroundColor = .black
        
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "저장한 상품 목록을 찾아보세요.", attributes: [.foregroundColor : UIColor.lightGray.cgColor])
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .darkGray
        searchBar.searchTextField.leftView?.tintColor = .lightGray
        searchBar.searchTextField.textColor = .white
        
        tableView.backgroundColor = .clear
        tableView.separatorColor = .white
    }

}
