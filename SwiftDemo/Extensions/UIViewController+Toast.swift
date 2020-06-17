//
//  UIViewController+Toast.swift
//  SwiftDemo
//
//  Created by Jesse on 2020/5/25.
//  Copyright © 2020 Jesse.Zhu. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertView(message: String) {
        if message.isEmpty {
            return
        }
        print(message)
    }
}
