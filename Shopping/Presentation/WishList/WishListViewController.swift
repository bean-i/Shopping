//
//  WishListViewController.swift
//  Shopping
//
//  Created by 이빈 on 2/26/25.
//

import UIKit
import SnapKit

struct WishListModel: Hashable, Identifiable {
    let id = UUID()
    let productName: String
    let date: Date
}

final class WishListViewController: UIViewController {
    
    enum Section: CaseIterable {
        case main
    }
    
    private let searchBar = UISearchBar()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    private var registration: UICollectionView.CellRegistration<UICollectionViewListCell, WishListModel>!
    private var dataSource: UICollectionViewDiffableDataSource<Section, WishListModel>!
    
    var list = [
        WishListModel(productName: "camera", date: Date()),
        WishListModel(productName: "book", date: Date()),
        WishListModel(productName: "glass", date: Date()),
        WishListModel(productName: "door", date: Date()),
        WishListModel(productName: "laptop", date: Date()),
        WishListModel(productName: "chair", date: Date())
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureDataSource()
        configureSnapshot()
    }
    
    private func configureView() {
        view.backgroundColor = .black
        
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .darkGray
        searchBar.searchTextField.textColor = .lightGray
        searchBar.searchTextField.leftView?.tintColor = .lightGray
        searchBar.placeholder = "위시리스트를 작성해 보세요"
        
        searchBar.delegate = self
        collectionView.delegate = self
    }
    
    private func configureDataSource() {
        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, WishListModel> { cell, indexPath, itemIdentifier in
            var contentConfig = UIListContentConfiguration.subtitleCell()
            contentConfig.text = itemIdentifier.productName
            contentConfig.textProperties.font = .boldSystemFont(ofSize: 16)
            contentConfig.secondaryText = "\(itemIdentifier.date)"
            contentConfig.textToSecondaryTextVerticalPadding = 5
            cell.contentConfiguration = contentConfig
            
            var backgroundConfig = UIBackgroundConfiguration.listHeader()
            backgroundConfig.backgroundColor = .white
            cell.backgroundConfiguration = backgroundConfig
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    private func configureSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, WishListModel>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list, toSection: Section.main)
        dataSource.apply(snapshot)
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .sidebarPlain)
        config.backgroundColor = .black
        config.showsSeparators = true
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    

}

extension WishListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            print("서치바 nil")
            return
        }
        searchBar.searchTextField.text = ""
        let newItem = WishListModel(productName: text, date: Date())
        list.append(newItem)
        configureSnapshot()
    }
}

extension WishListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        list.remove(at: indexPath.item)
        configureSnapshot()
    }
}
