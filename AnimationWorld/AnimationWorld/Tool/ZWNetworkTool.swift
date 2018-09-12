//
//  ZWNetworkTool.swift
//  AnimationWorld
//
//  Created by zzw on 2018/8/12.
//  Copyright © 2018年 zzw. All rights reserved.
//

import Foundation
import Moya

enum ZWNetworkTool {
    // 18237100685  yw12345
    case hostUrl(url:String)
}
extension ZWNetworkTool:TargetType {
    var headers: [String : String]? {
        return [:]
    }
//
    /// The target's base `URL`.
    var baseURL: URL {
        switch self {
        case .hostUrl(let url):
            return URL(string:url)!
        }

    }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .hostUrl:
            return ""
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
