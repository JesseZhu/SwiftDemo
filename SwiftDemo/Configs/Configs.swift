//
//  Config.swift
//  SwiftDemo
//
//  Created by Jesse on 2020/3/18.
//  Copyright © 2020 Jesse.Zhu. All rights reserved.
//

import Foundation

enum Keys {
    case umeng, baidu, jpush
    
    var apiKey: String {
        switch self {
            case .umeng: return ""
            case .baidu: return ""
            case .jpush: return ""
        }
    }
    
    var appId: String {
        return ""
    }
}

struct Configs {
    struct App {
        static let bundleIdentifier = "com.nng.SwiftDemo"
    }
    
    struct Path {
        static let Documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        static let Tmp = NSTemporaryDirectory()
    }
}

