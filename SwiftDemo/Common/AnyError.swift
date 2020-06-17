//
//  AnyError.swift
//  SwiftDemo
//
//  Created by Jesse on 2020/5/25.
//  Copyright © 2020 Jesse.Zhu. All rights reserved.
//

import Foundation

struct AnyError: Swift.Error {
    enum ParseFailed {
        case noMatch(msg: String)
    }
    
//    let ss = String(describing: self)
    let error: Swift.Error
}

extension AnyError: CustomStringConvertible{
    var description: String {
       return String(describing: error)
    }
}

extension AnyError: LocalizedError {
    public var errorDescription: String? {
        return error.localizedDescription
    }
}
