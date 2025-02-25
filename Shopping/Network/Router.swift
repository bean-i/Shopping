//
//  Router.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 2/6/25.
//

import Foundation
import Alamofire

enum Router {
    
    case ShoppingData(params: QueryParameters)
    
    static let baseURL = "https://openapi.naver.com/v1"
    
    var header: HTTPHeaders {
        return [
            "X-Naver-Client-Id": APIKey.naverClientID,
            "X-Naver-Client-Secret": APIKey.naverClientSecret
        ]
    }
    
    var method: HTTPMethod {
        switch self {
        case .ShoppingData:
            return .get
        }
    }
    
    var endpoint: URL? {
        switch self {
        case .ShoppingData:
            return URL(string: Router.baseURL + "/search/shop.json")
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .ShoppingData(let params):
            return [
                "query": params.searchKeyword,
                "display": "\(params.display)",
                "sort": "\(params.sort)",
                "start": params.start
            ]
        }
    }
    
}
