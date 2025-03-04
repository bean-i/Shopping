//
//  LikeListViewController.swift
//  Shopping
//
//  Created by 이빈 on 3/4/25.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import Toast

final class LikeListViewController: BaseViewController<LikeListView> {

    let realm = try! Realm()
    var list: Results<LikeTable>!
    var items: BehaviorRelay<[LikeTable]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        list = realm.objects(LikeTable.self)
        items.accept(Array(list))
    }
    
    override func configureRegister() {
        mainView.tableView.register(LikeListTableViewCell.self, forCellReuseIdentifier: LikeListTableViewCell.identifier)
    }
    
    override func bind() {
        // 테이블뷰
        items
            .bind(to: mainView.tableView.rx.items(cellIdentifier: LikeListTableViewCell.identifier, cellType: LikeListTableViewCell.self)) { (row, element, cell) in
                cell.setData(element)
                
                cell.likeButton.rx.tap
                    .asDriver()
                    .drive(with: self) { owner, _ in
                        print("like button tap")
                        cell.likeButton.updateLikeStatusTable(cell: cell, data: element)
                        owner.items.accept(Array(owner.list))
                        owner.view.makeToast("해당 상품을 저장 목록에서 삭제합니다.")
                    }
                    .disposed(by: cell.disposeBag)
                
            }
            .disposed(by: disposeBag)
        
        // 실시간 검색
        mainView.searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(with: self) { owner, value in
                print("입력됨:", value)
                if value.isEmpty {
                    print("empty")
                    owner.list = owner.realm.objects(LikeTable.self)
                } else {
                    owner.list = owner.realm.objects(LikeTable.self)
                        .where { $0.product.contains(value) }
                }
                owner.items.accept(Array(owner.list))
            }
            .disposed(by: disposeBag)
        
    }

}
