//
//  ZYApiProvider.swift
//  BinGuo
//
//  Created by wzy on 2019/9/18.
//  Copyright © 2019 wzy. All rights reserved.
//

import Foundation
import Moya

let apiProvider = MoyaProvider<ZYApiProvider>()

enum ZYApiProvider {
    case homeListApi(limit: Int, offset: Int)
    case rankingListApi
}

extension ZYApiProvider: TargetType{
    
    var baseURL: URL {
        return URL(string: "https://app.tomatoim.com")!
    }
    
    var path: String {
        switch self {
        case .homeListApi:
            return "/users/home"
        
        case .rankingListApi:
            return "/users/top"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .homeListApi,.rankingListApi:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
        
    }
    
    var task: Task {
        switch self {
        case let .homeListApi(limit, offset):
            return .requestParameters(parameters: ["limit":limit,"offset":offset], encoding: URLEncoding.default)
       
        case .rankingListApi:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
//        return ["Content-type" : "application/json"
//               ]
        
        
        return [
                "Content-type" : "application/json",

                "User-Agent":"Mozilla/5.0(Platform/iPhone; Brand/bingo; Version/2.6.6; Language/zh-Hans-US; Channels/0; Category/0; OS/unpb_12.2; Model/iPhone_Simulator)",
            
                "BINGO-TOKEN":"5093c9ab8e9f1eda42d85dea4b0056d6",
//            "BINGO-USERID":"ade2e1ff2a3a3e3cc349d60a27a1d78c67b4c527125e8a5ea1f11870ab7614b4",
            "Authorization":"EDBC5B2D-EE48-4100-A197-0252D5FA7F5E$13699764048"
                ]
    }
    
    
}
