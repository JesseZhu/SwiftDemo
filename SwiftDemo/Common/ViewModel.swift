//
//  BaseViewModel.swift
//  SwiftDemo
//
//  Created by Jesse on 2019/11/28.
//  Copyright © 2019 Jesse.Zhu. All rights reserved.
//

import UIKit

class ViewModel: NSObject {
    
    var dataList: [Any?] = [Any]()
    
    let loading = ActivityIndicator()
    let headerLoading = ActivityIndicator()
    let footerLoading = ActivityIndicator()
    
    override init() {
        super.init()
    }
    
    deinit {
        logDebug("\(type(of: self)): Deinited")
    }
}
