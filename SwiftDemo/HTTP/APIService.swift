
//
//  APIService.swift
//  SwiftDemo
//
//  Created by Jesse on 2019/12/2.
//  Copyright © 2019 Jesse.Zhu. All rights reserved.
//

import Foundation
import HandyJSON

struct APIService {
    
    func GET<T: HandyJSON>(url: String, completionHandler: @escaping (Swift.Result<T, NetworkError>) -> Void) -> Void {
        var request = URLRequest.init(url: URL(string: url)!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data  else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.badURL))
                }
                return
            }
            guard let error = error else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.badURL))
                }
                return
            }
            
            do {
                completionHandler(.success(T()))
            } catch {
                
            }
            
        })
        
        task.resume()
    }
}

