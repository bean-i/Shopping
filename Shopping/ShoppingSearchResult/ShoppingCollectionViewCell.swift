//
//  ShoppingCollectionViewCell.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/15/25.
//

import UIKit
import SnapKit
import Kingfisher

final class ShoppingCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "ShoppingCollectionViewCell"
    
    private let mainIamge = UIImageView()
    private let mallName = UILabel()
    private let title = UILabel()
    private let price = UILabel()
    
    override func configureHierarchy() {
        [
            mainIamge,
            mallName,
            title,
            price
        ].forEach { contentView.addSubview($0) }
    }
  
    override func configureLayout() {
        mainIamge.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.frame.width)
        }
        
        mallName.snp.makeConstraints { make in
            make.top.equalTo(mainIamge.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(10)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(mallName.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(10)
        }
        
        price.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
    }
    
    override func configureView() {
        mainIamge.layer.cornerRadius = 15
        mainIamge.clipsToBounds = true
        
        mallName.font = .systemFont(ofSize: 12)
        mallName.textColor = .lightGray
        mallName.numberOfLines = 0
        
        title.textColor = .white
        title.numberOfLines = 2
        title.font = .systemFont(ofSize: 14)
        
        price.font = .boldSystemFont(ofSize: 16)
        price.textColor = .white
        price.numberOfLines = 0
    }
    
    func setData(_ item: ShoppingItem) {
        let imgURL = URL(string: item.image)
        mainIamge.kf.setImage(with: imgURL, placeholder: UIImage(systemName: "arrowshape.down"))
        price.text = NumberFormatterManager.shared.format(number: Int(item.lprice)!)
        mallName.text = item.mallName
        title.text = item.title.escapingHTML
        
    }
    
}
