//
//  HTTPManager.swift
//  SwiftDemo
//
//  Created by Jesse on 2019/11/29.
//  Copyright © 2019 Jesse.Zhu. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON
import SwiftyJSON

enum NetworkError: Error {
    case badURL
    case notFind
    case error(error: Error)
}

final class HTTPManager: SessionDelegate {
    private var sessionMgr: Alamofire.SessionManager!
    static let shared = HTTPManager()
    
    override private init() {
        super.init()
        sessionMgr = SessionManager(configuration: URLSessionConfiguration.default)
//        sessionMgr.adapter = MyAdapter()
    }
    
    func  request(_ request: URLRequestConvertible, completionHandler: @escaping (Swift.Result<Any, NetworkError>) -> Void){
        sessionMgr.request(request).responseData{ (response) in
            print("debugDescription--->: " + response.debugDescription)
            switch response.result{
            case .success:
                if let value = response.result.value {
                    completionHandler(.success(value))
                }
            case .failure(let error):
                completionHandler(.failure(.error(error: error)))
            }
            
            
        }
    }
    
}
