//
//  ShoppingCollectionViewCell.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/15/25.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

final class ShoppingCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "ShoppingCollectionViewCell"
    
    let mainImage = UIImageView()
    let likeButton = LikeButton()
    let mallName = UILabel()
    let title = UILabel()
    let price = UILabel()
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func configureHierarchy() {
        [
            mainImage,
            likeButton,
            mallName,
            title,
            price
        ].forEach { contentView.addSubview($0) }
    }
  
    override func configureLayout() {
        mainImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.frame.width)
        }
        
        likeButton.snp.makeConstraints { make in
            make.trailing.equalTo(mainImage.snp.trailing).inset(5)
            make.bottom.equalTo(mainImage.snp.bottom).inset(5)
            make.size.equalTo(20)
        }
        
        mallName.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(5)
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
        mainImage.layer.cornerRadius = 15
        mainImage.clipsToBounds = true
        
        likeButton.tintColor = .black
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        
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
        mainImage.kf.setImage(with: imgURL, placeholder: UIImage(systemName: "arrowshape.down"))
        price.text = NumberFormatterManager.shared.format(number: Int(item.lprice)!)
        mallName.text = item.mallName
        title.text = item.title.escapingHTML
        
    }
    
}
