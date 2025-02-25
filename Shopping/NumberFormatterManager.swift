//
//  NumberFormatterManager.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/16/25.
//

import UIKit

class NumberFormatterManager {
    static let shared = NumberFormatterManager()
    
    private init() { }
    
    lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    func format(number: Int) -> String {
        return formatter.string(for: number) ?? ""
    }
    
}
