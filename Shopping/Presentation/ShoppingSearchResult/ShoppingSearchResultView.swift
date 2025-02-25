//
//  ShoppingSearchResultView.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/16/25.
//

import UIKit
import SnapKit

final class ShoppingSearchResultView: BaseView {

    let resultCountLabel = UILabel()
    let sortCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let shoppingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override func configureHierarchy() {
        addSubview(resultCountLabel)
        addSubview(sortCollectionView)
        addSubview(shoppingCollectionView)
    }
    
    override func configureLayout() {
        resultCountLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(20)
        }
        
        sortCollectionView.snp.makeConstraints { make in
            make.top.equalTo(resultCountLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        shoppingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sortCollectionView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        sortCollectionView.backgroundColor = .black
        
        shoppingCollectionView.backgroundColor = .black
        
        resultCountLabel.textColor = .systemGreen
        resultCountLabel.font = .systemFont(ofSize: 12, weight: .bold)
        
        sortCollectionView.collectionViewLayout = createSortCollectionViewLayout()
        sortCollectionView.register(SortCollectionViewCell.self, forCellWithReuseIdentifier: SortCollectionViewCell.identifier)
        
        shoppingCollectionView.collectionViewLayout = createShoppingCollectionViewLayout()
        shoppingCollectionView.register(ShoppingCollectionViewCell.self, forCellWithReuseIdentifier: ShoppingCollectionViewCell.identifier)
        
    }
    
    private func createSortCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 80, height: 50)
        return layout
    }
    
    private func createShoppingCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let spacing: CGFloat = 20
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        let deviceWidth = UIScreen.main.bounds.width
        let width = (deviceWidth - (spacing * 3)) / 2
        layout.itemSize = CGSize(width: width, height: width + 100)
        
        return layout
    }
    
}
