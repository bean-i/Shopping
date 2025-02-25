//
//  ShoppingNetworkManager.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/17/25.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

enum APIError: Error {
    case invalidURL
    case naverError(code: String)
    case afError
}

struct ShoppingError: Decodable {
    let errorMessage: String
    let errorCode: String
}

final class ShoppingNetworkManager {
    
    static let shared = ShoppingNetworkManager()
    
    private init() { }
    
    func getShoppingData<T: Decodable>(api: Router,
                                       type: T.Type) -> Single<T> {
        return Single.create { value in
            guard let endpoint = api.endpoint else {
                value(.failure(APIError.invalidURL))
                return Disposables.create {
                    print("통신 끝")
                }
            }
            
            AF.request(endpoint,
                       method: api.method,
                       parameters: api.parameters,
                       encoding: URLEncoding.queryString,
                       headers: api.header)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let result):
                    if let data = response.data {
                        do { // 정상으로 들어오지만, 네이버 에러에 해당하면 에러 방출
                            let decodeData = try JSONDecoder().decode(ShoppingError.self, from: data)
                            value(.failure(APIError.naverError(code: decodeData.errorCode)))
                        } catch { // 에러로 디코딩 되지 않으면 네트워크 성공으로 간주
                            value(.success(result))
                        }
                    }
                case .failure(let error):
                    if let data = response.data {
                        do { // 네이버 에러에 해당하면 에러 방출
                            let decodeData = try JSONDecoder().decode(ShoppingError.self, from: data)
                            value(.failure(APIError.naverError(code: decodeData.errorCode)))
                        } catch { // alamofire 에러
                            value(.failure(APIError.afError))
                        }
                    }
                }
            }
            return Disposables.create {
                print("통신 끝")
            }
        }
    }
}
