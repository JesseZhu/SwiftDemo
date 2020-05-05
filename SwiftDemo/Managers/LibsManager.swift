//
//  LibsManager.swift
//  SwiftDemo
//
//  Created by Jesse on 2020/3/18.
//  Copyright © 2020 Jesse.Zhu. All rights reserved.
//

import UIKit
import CocoaLumberjack

class LibsManager: NSObject {
    static let shared = LibsManager()
    
    override init() {
        super.init()
//        setup()
    }
    
    func setup() {
        let libManager = LibsManager.shared
        libManager.setupCocoaLumberjack()
    }
    
    fileprivate func setupCocoaLumberjack() {
        DDLog.add(DDTTYLogger.sharedInstance!) // Xcode console
        
        let fileLogger: DDFileLogger = DDFileLogger()
        fileLogger.rollingFrequency = TimeInterval(60*60*24) //24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 8
        DDLog.add(fileLogger)
    }
}
