//
//  LikeListTableViewCell.swift
//  Shopping
//
//  Created by 이빈 on 3/4/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class LikeListTableViewCell: BaseTableViewCell {
    
    static let identifier = "LikeListTableViewCell"
    var disposeBag = DisposeBag()

    let mainImage = UIImageView()
    
    let labelView = UIView()
    let mallName = UILabel()
    let title = UILabel()
    let price = UILabel()
    
    let likeButton = LikeButton()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func configureHierarchy() {
        [
            mallName,
            title,
            price,
        ].forEach { labelView.addSubview($0) }
        
        [
            mainImage,
            labelView,
            likeButton
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        mainImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
            make.size.equalTo(100)
            make.bottom.equalToSuperview().inset(10)
        }
        
        labelView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(mainImage.snp.trailing).offset(10)
            make.trailing.equalTo(likeButton.snp.leading).inset(10)
        }
        
        mallName.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(mallName.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        price.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
    }
    
    override func configureView() {
        backgroundColor = .clear
        
        mainImage.layer.cornerRadius = 15
        mainImage.clipsToBounds = true
        
        likeButton.tintColor = .white
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        
        mallName.font = .systemFont(ofSize: 12)
        mallName.textColor = .lightGray
        mallName.numberOfLines = 0
        
        title.numberOfLines = 0
        title.textColor = .white
        title.numberOfLines = 2
        title.font = .systemFont(ofSize: 14)
        
        price.font = .boldSystemFont(ofSize: 16)
        price.textColor = .white
        price.numberOfLines = 0
    }
    
    func setData(_ item: LikeTable) {
        
        if let strURL = item.image,
           let imgURL = URL(string: strURL) {
            mainImage.kf.setImage(with: imgURL, placeholder: UIImage(systemName: "arrowshape.down"))
        } else {
            mainImage.image = UIImage(systemName: "xmark")
        }
        
        price.text = Int(item.price)?.formatted()
        mallName.text = item.market
        title.text = item.product.escapingHTML
        likeButton.isSelected = item.isSelect
    }

}
