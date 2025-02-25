//
//  SortCollectionViewCell.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/16/25.
//

import UIKit
import SnapKit

final class SortCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "SortCollectionViewCell"
    
    private let backView = UIView()
    let sortLabel = UILabel()
    
    override func configureHierarchy() {
        backView.addSubview(sortLabel)
        addSubview(backView)
    }

    override func configureLayout() {
        backView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview().inset(10)
        }
        
        sortLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func configureView() {
        backView.backgroundColor = .black
        backView.layer.cornerRadius = 8
        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.white.cgColor
        
        sortLabel.textColor = .white
        sortLabel.font = .systemFont(ofSize: 14)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backView.backgroundColor = .white
                sortLabel.textColor = .black
            } else {
                backView.backgroundColor = .black
                sortLabel.textColor = .white
            }
        }
    }
}
