//
//  SortModel.swift
//  Shopping
//
//  Created by 이빈 on 2/25/25.
//

import Foundation

enum Sort: String, CaseIterable {
    case byAccuracy = "정확도"
    case byDate = "날짜순"
    case byHighestPrice = "가격높은순"
    case byLowestPrice = "가격낮은순"
    
    var apiParameter: String {
        switch self {
        case .byAccuracy:
            return "sim"
        case .byDate:
            return "date"
        case .byHighestPrice:
            return "dsc"
        case .byLowestPrice:
            return "asc"
        }
    }
}
