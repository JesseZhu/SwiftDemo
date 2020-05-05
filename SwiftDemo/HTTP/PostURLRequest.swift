//
//  PostURLRequest.swift
//  SwiftDemo
//
//  Created by Jesse on 2019/12/1.
//  Copyright © 2019 Jesse.Zhu. All rights reserved.
//

import Foundation
import SwiftyJSON
import HandyJSON
import Alamofire

enum PostRequest {
    struct QueryTrafficParamters {
        let coordType: String
        let appid: String
        let radius: Float
        let longitude: Double
        let latitude: Double
    }
    
    
    case queryPopular(String, Int)
    case queryMusic
}

extension PostRequest: BaseURLRequst {
    var host: String {
        return "http://47.92.171.223:17120"
    }
    
    var path: String {
        switch self {
        case .queryPopular: return "/api/posts/popular"
        case .queryMusic: return ""
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case let .queryPopular(lastPostId, size):
            return[
                "lastPostId": lastPostId,
                "size": size
            ]
            
        case .queryMusic:
            return ["":""]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .queryMusic:
            return .post
        default:
            return .get
        }
    }
    
    var header: [String : String]? {
        let pairs = defalutHeaders
        //do some thing
        
        return pairs
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .queryPopular: return URLEncoding.default
        default: return JSONEncoding.default
        }
    }
}


extension HTTPManager {
//    func queryPopular(lastPostId: String, size: Int, success:@escaping(_ response: Any)->(), failure:@escaping(_ error:Error)->()) {
//        request(PostRequest.queryPopular(lastPostId, size), success: success, failure: failure)
//    }
    
    func queryPopularPosts(lastPostId: String, size: Int, completionHandle: @escaping (Swift.Result<[PostModel?], NetworkError>) -> Void) -> Void {
        request(PostRequest.queryPopular(lastPostId, size)) { (result) in
            switch result {
            case .success(let sucess):
                let json =  JSON(sucess)
                if let list = JSONDeserializer<PostModel>.deserializeModelArrayFrom(json: json.description) {
                    completionHandle(.success(list))
                }
//                if json["statusCode"] == 200 {
//                    if let list = JSONDeserializer<PostModel>.deserializeModelArrayFrom(json: json.description) {
//                        completionHandle(.success(list))
//                    }
//                }else{
//                    completionHandle(.failure(NetworkError.notFind))
//                }
               
            case .failure(let failure):
                print("request fail ->:" + failure.localizedDescription)
                completionHandle(.failure(NetworkError.error(error: failure)))
            }

        }
    }
}
