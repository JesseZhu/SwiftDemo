
//
//  GithubAPI.swift
//  SwiftDemo
//
//  Created by Jesse on 2020/5/11.
//  Copyright © 2020 Jesse.Zhu. All rights reserved.
//

import Foundation
import RxSwift

class GithubAPI {
    let urlSession: URLSession
    
    static let shareAPI = GithubAPI(URLSession: URLSession.shared)
    
    init(URLSession: URLSession) {
        self.urlSession = URLSession
    }
    
    func userNameAvailable(_ userName: String) -> Observable<Bool> {
        let url = URL(string: "https://github.com/\(userName)")!
        let request = URLRequest(url: url)
        return self.urlSession.rx.response(request: request).map { response, _ -> Bool  in
            return response.statusCode == 200
        }
    .catchErrorJustReturn(false)
    }
    
    func register(_ username: String, pwd: String) -> Observable<Bool> {
        let registerResult = arc4random() % 5 == 0 ? false : true
        return Observable.just(registerResult)
            .delay(.seconds(2), scheduler: MainScheduler.instance)
    }
    
}
