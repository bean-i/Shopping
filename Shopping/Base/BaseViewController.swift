//
//  BaseViewController.swift
//  TamaJoy
//
//  Created by 이빈 on 2/21/25.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController<T: UIView>: UIViewController {
    
    var mainView: T {
        return view as! T
    }
    
//    var viewModel: any BaseViewModel
//    var disposeBag = DisposeBag()
//    
//    init(model: any BaseViewModel) {
//        self.viewModel = model
//        super.init(nibName: nil, bundle: nil)
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func loadView() {
        self.view = T(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRegister()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .black
        configureNavigation()
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    func configureRegister() { }
    
    func bind() { }
    
}
