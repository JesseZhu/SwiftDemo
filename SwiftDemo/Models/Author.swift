//
//  Author.swift
//  SwiftDemo
//
//  Created by Jesse on 2019/12/1.
//  Copyright © 2019 Jesse.Zhu. All rights reserved.
//

import Foundation
import HandyJSON

class AuthorModel: HandyJSON {
    let id: String? = nil
    let name: String? = nil
    let avatorUrl: String? = nil
    let phone: String? = nil
    let sex: Int? = nil
    let provinceCode: String? = nil
    let cityCode: String? = nil
    let vip: Bool? = nil
    
    required init() {}
}

struct ImageModel: HandyJSON {
    let url: String? = nil
    let width: Float? = nil
    let heitght: Float? = nil
}
