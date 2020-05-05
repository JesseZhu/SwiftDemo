//
//  PIOURLRequest.swift
//  SwiftDemo
//
//  Created by Jesse on 2019/11/29.
//  Copyright © 2019 Jesse.Zhu. All rights reserved.
//

import Foundation
import Alamofire

enum PIORequest {
    struct QueryTrafficParamters {
        let coordType: String
        let appid: String
        let radius: Float
        let longitude: Double
        let latitude: Double
    }
    
    
    case queryTraffic(QueryTrafficParamters)
    case queryMusic
}

extension PIORequest: BaseURLRequst {
    var host: String {
        return "http://161.117.83.241:5088"
    }
    
    var path: String {
        switch self {
        case .queryTraffic: return "/companion/sea/traffic/queryTraffic"
        case .queryMusic: return ""
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .queryTraffic(let parameters):
            return[
                "coordType": parameters.coordType,
                "appid": parameters.appid,
                "radius": parameters.radius,
                "longitude": parameters.longitude,
                "latitude": parameters.latitude
            ]
            
        case .queryMusic:
            return ["":""]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .queryTraffic:
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
        case .queryTraffic: return JSONEncoding.default
        default: return URLEncoding.default
        }
    }
}


extension HTTPManager {
    func queryTrffic(parameters: PIORequest.QueryTrafficParamters, success:@escaping(_ response:[String:AnyObject])->(), failure:@escaping(_ error:Error)->()) {
//        request(PIORequest.queryTraffic(parameters), success: success, failure: failure)
    }
}
