//
//  TestRxViewController.swift
//  SwiftDemo
//
//  Created by Jesse on 2020/5/8.
//  Copyright © 2020 Jesse.Zhu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable

class TestRxViewController: BaseViewController, StoryboardBased {
    @IBOutlet weak var number1TF: UITextField!
    @IBOutlet weak var number2TF: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //被观察者 订阅
        number1TF.rx.text.orEmpty.asObservable().filter {
            $0 != ""
        }.subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
        
        Observable.combineLatest(number1TF.rx.text.orEmpty, number2TF.rx.text.orEmpty){ number1, number2 in
            (Int(number1) ?? 0) + (Int(number2) ?? 0)
        }
        .map(String.init)
        .bind(to: resultLabel.rx.text)
        .disposed(by: disposeBag)
    }
}
