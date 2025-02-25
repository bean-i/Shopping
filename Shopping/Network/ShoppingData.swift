//
//  ShoppingData.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/15/25.
//

import Foundation

struct ShoppingData: Decodable {
    let total: Int
    let items: [ShoppingItem]
}

struct ShoppingItem: Decodable {
    let image: String
    let mallName: String
    let title: String
    let lprice: String
}
