//
//  BaseViewModel.swift
//  TamaJoy
//
//  Created by 이빈 on 2/21/25.
//

import Foundation

protocol BaseViewModel {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
    
}
