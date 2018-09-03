//
//  ZWNetworkTool.swift
//  AnimationWorld
//
//  Created by zzw on 2018/8/12.
//  Copyright © 2018年 zzw. All rights reserved.
//

import Foundation
import Moya

let url = "http://fuciyuanjson.biaoqingdou.com/fuciyuan/v1/comichot_1.json?&ver=2.1.3&plat=ip&channel=appstore&app=FuCiYuan"

enum ZWNetworkTool {
    // 18237100685  yw12345
    case home(url:String)
    case dynamicData(token:String,pagesize:String,pageindex:String)
}
extension ZWNetworkTool:TargetType {
    var headers: [String : String]? {
        return [:]
    }
//
    /// The target's base `URL`.
    var baseURL: URL {
        switch self {
        case .dynamicData( _, _, _):
            return URL(string:url)!
        case .home(let url):
            return URL(string:url)!
        }


    }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .home:
            return ""
        case .dynamicData( _, _, _):
            return "app/personal/queryBlog"
        }

    }

    /// The HTTP method used in the request.
    var method: Moya.Method {

        return .get


    }

    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "单元测试".data(using: .utf8)!
    }

    /// The type of HTTP task to be performed.
    var task: Task {
        return .requestPlain
//        switch self {
//        case .user(let username, let password):
//            return .requestParameters(parameters: ["phone":username,"pwd":password], encoding: URLEncoding.default)
//        case .dynamicData(let token, let pagesize,let pageindex):
//            return .requestParameters(parameters: ["token":token,"pagesize":pagesize,"pageindex":pageindex], encoding: URLEncoding.default)
//        }

    }

    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }


}
let zwNetTool = MoyaProvider<ZWNetworkTool>()
