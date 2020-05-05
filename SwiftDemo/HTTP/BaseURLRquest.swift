//
//  BaseURLRquest.swift
//  SwiftDemo
//
//  Created by Jesse on 2019/11/29.
//  Copyright © 2019 Jesse.Zhu. All rights reserved.
//

import Foundation
import Alamofire

protocol BaseURLRequst: URLRequestConvertible {
    var host: String { get }
    var path: String { get }
    var  parameters: [String: Any]? { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var encoding: ParameterEncoding { get }
}

extension BaseURLRequst {
    func asURLRequest() throws -> URLRequest {
        let urlString = host + path
        var mutableURLRequest = try URLRequest.init(url: urlString, method: method, headers: header)
        
//        var mutableURLRequest = URLRequest(url: try url.asURL())
//        mutableURLRequest.httpMethod = method.rawValue
//        if let header = header {
//            for (headerField, headerValue) in header {
//                mutableURLRequest.setValue(headerValue, forHTTPHeaderField: headerField)
//            }
//        }
        
        if let parameters = parameters {
            mutableURLRequest =  try encoding.encode(mutableURLRequest, with: parameters)
        }
            
        return mutableURLRequest
    }
    
    var defalutHeaders: [String: String]? {
        var headers: [String: String] = [
            "User-Agent": SessionManager.defaultHTTPHeaders["User-Agent"]! + "iOS"
        ]
        
        if path.contains("user/info") {
            headers["sign"] = "sign"
        }
        
//        if "token" == "token" {
//            headers["token"] = "token"
//        }
        return headers
    }
}

