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
    let id: UUID
    let image: String
    let mallName: String
    let title: String
    let lprice: String
    
    enum CodingKeys: String, CodingKey {
        case image
        case mallName
        case title
        case lprice
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        image = try container.decode(String.self, forKey: .image)
        mallName = try container.decode(String.self, forKey: .mallName)
        title = try container.decode(String.self, forKey: .title)
        lprice = try container.decode(String.self, forKey: .lprice)
        
        id = UUID()
    }
}
