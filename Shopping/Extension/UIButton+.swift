//
//  UIButton+.swift
//  Shopping
//
//  Created by 이빈 on 3/4/25.
//

import UIKit

extension UIButton.Configuration {
    
    static func customStyle() -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.baseForegroundColor = .black
        config.baseBackgroundColor = .white
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        return config
    }
    
}
