//
//  ShoppingNetworkManager.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/17/25.
//

import UIKit
import Alamofire

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

struct QueryParameters {
    var searchKeyword: String = ""
    let display = 100
    var start = 1
    var sort = Sort.byAccuracy.apiParameter
}

class ShoppingNetworkManager {
    
    static let shared = ShoppingNetworkManager()
    
    private init() { }
    
    func getShoppingData<T: Decodable>(api: Router,
                                    type: T.Type,
    completionHandler: @escaping (T) -> Void) {
        
        guard let endpoint = api.endpoint else {
            print("url 오류")
            return
        }
        
        AF.request(endpoint,
                   method: api.method,
                   parameters: api.parameters,
                   encoding: URLEncoding.queryString,
                   headers: api.header)
//        .validate(statusCode: 200..<400)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                print("success")
                completionHandler(value)
            case .failure(let error):
                print("fail")
                print(error)
            }
        }
    }
    
//    func getData(params: QueryParameters, completionHandler: @escaping (ShoppingData) -> Void) {
//        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(params.searchKeyword!)&display=\(params.display)&sort=\(params.sort)&start=\(params.start)"
//        
//        AF.request(
//            url,
//            method: .get,
//            headers: params.header
//        )
//            .responseDecodable(of: ShoppingData.self) { response in
//            switch response.result {
//            case .success(let value):
//                completionHandler(value)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
}
