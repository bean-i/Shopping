//
//  BaseViewController.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/16/25.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBasicDesign()
        configureHierarchy()
        configureLayout()
        configureView()
        configureDelegate()
    }
    
    func configureBasicDesign() {
        view.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backButtonTitle = ""
//        navigationController?.navigationBar.topItem?.title = ""
    }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureView() { }
    
    func configureDelegate() { }
}
