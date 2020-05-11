//
//  LoginVC.swift
//  SwiftDemo
//
//  Created by Jesse on 2020/3/18.
//  Copyright © 2020 Jesse.Zhu. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

class LoginVC: BaseViewController, StoryboardBased {
    
    @IBOutlet weak var usesNameTF: UITextField!
    @IBOutlet weak var pwdTF: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var testButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login..."
        
        let viewModel = LoginVM(userNmae: usesNameTF.rx.text.orEmpty.asDriver(), password: pwdTF.rx.text.orEmpty.asDriver())
        
        viewModel.loginEnabled.asObservable().bind(to: loginBtn.rx.isEnabled).disposed(by: disposeBag)
        
        testButton.rx.tap.subscribe(onNext: {
            self.show(TestRxViewController.instantiate(), sender: nil)
        }).disposed(by: disposeBag)
        
        viewModel.validatedUsername.asObservable().subscribe(onNext: {
            print("111:", $0)
        })
        .disposed(by: disposeBag)
    }
}

//extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {
//  public func unwrap<Wrapped>() -> Driver<Wrapped> where Element == Wrapped? {
//    return flatMap { value in
//        value.flatMap(<#T##transform: (Wrapped) throws -> U?##(Wrapped) throws -> U?#>)
//        value.optional.map { Driver<Element>.just($0) } ?? Driver<Element>.empty()
//    }
//  }
//}
