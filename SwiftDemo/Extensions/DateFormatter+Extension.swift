//
//  DateFormatter+Extension.swift
//  SwiftDemo
//
//  Created by Jesse on 2019/12/4.
//  Copyright © 2019 Jesse.Zhu. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let noneShort: DateFormatter = {
        let candidate = DateFormatter()
        candidate.locale = .current
        candidate.timeZone = .current
        candidate.dateStyle = .none
        candidate.timeStyle = .short
        return candidate
    }()
    
    static let shortNone: DateFormatter = {
        let candidate = DateFormatter()
        candidate.locale = .current
        candidate.timeZone = .current
        candidate.dateStyle = .short
        candidate.timeStyle = .none
        return candidate
    }()
    
    static let ymdhms: DateFormatter = {
        let candidate = DateFormatter()
        candidate.locale = .current
        candidate.timeZone = .current
        candidate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return candidate
    }()
    
    static let ymdhm: DateFormatter = {
        let candidate = DateFormatter()
        candidate.locale = .current
        candidate.timeZone = .current
        candidate.dateFormat = "yyyy-MM-dd HH:mm"
        return candidate
    }()
    
    static let mdhm: DateFormatter = {
        let candidate = DateFormatter()
        candidate.locale = .current
        candidate.timeZone = .current
        candidate.dateFormat = "MM-dd HH:mm"
        return candidate
    }()
    
    static let ymdh: DateFormatter = {
        let candidate = DateFormatter()
        candidate.locale = .current
        candidate.timeZone = .current
        candidate.dateFormat = "yyyy-MM-dd HH"
        return candidate
    }()
    
    static let ymd: DateFormatter = {
        let candidate = DateFormatter()
        candidate.locale = .current
        candidate.timeZone = .current
        candidate.dateFormat = "yyyy-MM-dd"
        return candidate
    }()
    
    static let hm: DateFormatter = {
        let candidate = DateFormatter()
        candidate.locale = .current
        candidate.timeZone = .current
        candidate.dateFormat = "HH:mm"
        return candidate
    }()
}
