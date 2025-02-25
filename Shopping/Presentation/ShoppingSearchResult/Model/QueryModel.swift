//
//  QueryModel.swift
//  Shopping
//
//  Created by 이빈 on 2/25/25.
//

import Foundation

struct QueryParameters {
    var searchKeyword: String = ""
    let display = 100
    var start = 1
    var sort = Sort.byAccuracy.apiParameter
}
