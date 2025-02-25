//
//  String+Extension.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/16/25.
//

import Foundation

extension String {
    var escapingHTML: String {
        let patten = "<[^>]+>|&quot;|<b>|</b>"
        
        return self.replacingOccurrences(of: patten,
                                         with: "",
                                         options: .regularExpression,
                                         range: nil)
    }
}
