//
//  ShoppingSearchResultViewController.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/15/25.
//

import UIKit
import Alamofire
import SnapKit

final class ShoppingSearchResultViewController: BaseViewController {
    
    var mainView = ShoppingSearchResultView()
    let viewModel = ShoppingSearchResultViewModel()

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        print(#function)
        super.viewDidLoad()
        configureDelegate()
        bindData()
    }
    
    deinit {
        print("ShoppingSearchResultViewController Deinit")
    }
    
    override func configureDelegate() {
        mainView.sortCollectionView.delegate = self
        mainView.sortCollectionView.dataSource = self
        
        mainView.shoppingCollectionView.delegate = self
        mainView.shoppingCollectionView.dataSource = self
    }
    
    private func bindData() {
        print(#function)
        
        viewModel.inputViewDidTrigger.value = ()
        
        viewModel.outputTitle.bind { [weak self] text in
            print("outputtitle bind")
            self?.navigationItem.title = text
        }
        
        viewModel.outputShoppingItems.lazyBind { [weak self] _ in
            print("shopping items bind")
            self?.mainView.shoppingCollectionView.reloadData()
            self?.mainView.shoppingCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
        
        viewModel.outputItemCount.lazyBind { [weak self] count in
            self?.mainView.resultCountLabel.text = "\(count)개의 검색 결과"
        }
    }

}

// MARK: - CollectionView Delegate
extension ShoppingSearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case mainView.sortCollectionView:
            return Sort.allCases.count
        case mainView.shoppingCollectionView:
            return viewModel.outputShoppingItems.value.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case mainView.sortCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SortCollectionViewCell.identifier, for: indexPath) as! SortCollectionViewCell
            
            cell.sortLabel.text = Sort.allCases[indexPath.item].rawValue
            if indexPath.item == 0 {
                cell.isSelected = true
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            }
            return cell
            
        case mainView.shoppingCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingCollectionViewCell.identifier, for: indexPath) as! ShoppingCollectionViewCell
            cell.setData(viewModel.outputShoppingItems.value[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        // 뷰모델에 넘겨주기
        if collectionView == mainView.sortCollectionView {
            viewModel.inputNewSortParameter.value = Sort.allCases[indexPath.item].apiParameter
        }
    }
}

