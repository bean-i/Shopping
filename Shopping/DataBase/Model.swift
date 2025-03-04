//
//  Model.swift
//  Shopping
//
//  Created by 이빈 on 3/4/25.
//

import Foundation
import RealmSwift

// 이미지, 마켓 이름, 상품 이름, 가격, 좋아요 여부
class LikeTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var image: String?
    @Persisted var market: String
    @Persisted(indexed: true) var product: String
    @Persisted var price: String
    @Persisted var isSelect: Bool
    
    convenience init(image: String?,
                     market: String,
                     product: String,
                     price: String,
                     isSelect: Bool) {
        self.init()
        self.image = image
        self.market = market
        self.product = product
        self.price = price
        self.isSelect = isSelect
    }
}

