//
//  LoginVM.swift
//  SwiftDemo
//
//  Created by Jesse on 2020/3/18.
//  Copyright © 2020 Jesse.Zhu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginVM: ViewModel {
    let loginEnabled: Driver<Bool>
    
    let validatedUsername: Driver<Bool>
    let validatedPwd: Driver<Bool>
    
    init(userNmae: Driver<String>, password: Driver<String>) {
        validatedUsername = userNmae.map({ username -> Bool in
            if username.count > 3 && username.count < 8 {
                return true
            }
            return false
        })
        
        validatedPwd = password.map({
            return $0.count > 5
        })
        
        loginEnabled = Driver.combineLatest(validatedUsername, validatedPwd) {
            return $0 && $1
        }.distinctUntilChanged()
    }

    let relay = BehaviorRelay<Void>(value: ())
}
