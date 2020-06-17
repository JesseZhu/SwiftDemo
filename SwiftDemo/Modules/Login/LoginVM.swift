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

enum ValidationResult {
    case ok(message: String)
    case empty
    case validating
    case failed(message: String)
    
    var isSucess: Bool {
        switch self {
            case .ok:
                return true
            default:
                return false
        }
    }
    
    var description: String {
        switch self {
            case .ok(let msg): return msg
            case.empty: return ""
            case .validating: return "validatig ..."
            case .failed(let errMsg): return errMsg
        }
    }
    
    var textColor: UIColor {
        switch self {
            case .ok:
                return .green
            case .empty:
                return .black
            default:
                return .red
        }
    }
}

class LoginVM: ViewModel {
    let loginEnabled: Driver<Bool>
    
    let registAction = BehaviorRelay<Void>(value: ())
    
    let validatedUsername: Driver<ValidationResult>
    let validatedPwd: Driver<ValidationResult>
    
    //output
    let registed: Observable<Bool>
    let sucessMessage: Observable<String>
    let errorMessage: Observable<String>
    
    init(userNmae: Driver<String>, password: Driver<String>) {
        validatedUsername = userNmae.flatMapLatest({ username -> Driver<ValidationResult> in
            if username.isEmpty {
                return Driver.just(.empty)
            }
            let loadingValue = ValidationResult.validating
            return GithubAPI.shareAPI.userNameAvailable(username).map{
                if $0 {
                    return .ok(message: "验证通过")
                }else{
                    return .failed(message: "验证失败(can not find \(username)")
                }
            }.startWith(loadingValue)
                .asDriver(onErrorJustReturn: .failed(message: "error connecting server"))
        })
        
//        validatedUsername = userNmae.map({ username -> ValidationResult in
//            print(username)
//             else if username.count > 3 && username.count < 8 {
//
//            }else {
//                return .failed(message: "验证失败(3-8个字符)")
//            }
//        })
        registed = registAction.withLatestFrom(
            Driver.combineLatest(userNmae, password),
            resultSelector: {(name, pwd) in
            return (name, pwd)
            })
        .flatMapLatest { (_, args) -> Observable<Bool> in
            let (name, pwd) = args
            return GithubAPI.shareAPI.register(name, pwd: pwd).observeOn(MainScheduler.instance)
                .catchErrorJustReturn(false)
        }
        
        let userNameAndPwd = Driver.combineLatest(userNmae, password)
        let registeded = registAction.withLatestFrom(userNameAndPwd).flatMapLatest { (username, pwd) -> Observable<Bool> in
            GithubAPI.shareAPI.register(username, pwd: pwd)
                .observeOn(MainScheduler.instance)
                .catchErrorJustReturn(false)
        }
        
        
        let registerResult = registAction.withLatestFrom(userNameAndPwd).flatMapLatest { (username, pwd) -> Observable<Bool> in
            GithubAPI.shareAPI.register(username, pwd: pwd)
                .observeOn(MainScheduler.instance)
                .catchErrorJustReturn(false)
        }
//        .subscribe{
//            print("********:", $0)
//        }
        
//        registAction.flatMapLatest { _ -> Observable<Bool> in
//
//        }
        
        validatedPwd = password.map({
            if $0.isEmpty {
                return .empty
            }
            return $0.count > 5 ? .ok(message: "验证通过") : .failed(message: "验证失败（大于5个字符）")
        })
        
        loginEnabled = Driver.combineLatest(validatedUsername, validatedPwd) {
            return $0.isSucess && $1.isSucess
        }.distinctUntilChanged()
        
        sucessMessage = registerResult.map{
            $0 ? "操作成功" : "操作失败"
        }.share(replay: 1)
        
//        sucessMessage = Observable.just("操作成功")
        
//        registerResult.share(replay: <#T##Int#>, scope: <#T##SubjectLifetimeScope#>)
        errorMessage = Observable.just("Oops 出错了").share(replay: 1)
    }
}
