//
//  LogManager.swift
//  SwiftDemo
//
//  Created by Jesse on 2020/3/18.
//  Copyright © 2020 Jesse.Zhu. All rights reserved.
//

import Foundation
import CocoaLumberjack

public func logDebug(_ message: @autoclosure () -> String) {
    DDLogDebug(message())
}
