//
//  LikeButton.swift
//  Shopping
//
//  Created by 이빈 on 3/4/25.
//

import UIKit
import RealmSwift

final class LikeButton: UIButton {
    
    let realm = try! Realm()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton() {
        self.setImage(UIImage(systemName: "heart"), for: .normal)
        self.setImage(UIImage(systemName: "heart.fill"), for: .selected)
    }
    
    func updateLikeStatusCollection(cell: ShoppingCollectionViewCell, data: ShoppingItem) {
        cell.likeButton.isSelected.toggle()
        // isSelected: true -> 저장
        // isSelected: false -> 삭제
        
        let new = LikeTable(
            image: data.image,
            market: data.mallName,
            product: data.title,
            price: data.lprice,
            isSelect: cell.likeButton.isSelected
        )
        
        if cell.likeButton.isSelected {
            addData(data: new)
        } else {
            deleteData(data: new)
        }
    }
    
    func updateLikeStatusTable(cell: LikeListTableViewCell, data: LikeTable) {
        cell.likeButton.isSelected.toggle()
        // isSelected: true -> 저장
        // isSelected: false -> 삭제
        let new = LikeTable(
            image: data.image,
            market: data.market,
            product: data.product,
            price: data.price,
            isSelect: cell.likeButton.isSelected
        )
        
        if cell.likeButton.isSelected {
            addData(data: new)
        } else {
            deleteData(data: data)
        }
    }
    
    private func addData(data: LikeTable) {
        print(#function)
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("Realm에 저장 실패")
        }
    }
    
    private func deleteData(data: LikeTable) {
        print(#function)
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            print("Realm에 삭제 실패")
        }
    }
    
}
