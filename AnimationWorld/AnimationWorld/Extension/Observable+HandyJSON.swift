//
//  Observable+HandyJSON.swift
//  AnimationWorld
//
//  Created by zzw on 2018/8/12.
//  Copyright © 2018年 zzw. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import HandyJSON
// MARK: - Json -> Model
extension Response {
    // 将Json解析为单个Model
    public func mapObject<T: HandyJSON>(_ type: T.Type) throws -> T {
//        print(try mapString())
        guard let json = try mapJSON() as? [String : Any] else {
            throw MoyaError.jsonMapping(self)
        }

        guard let jsonStr = (json["result"] as? [String : Any]) else {
            throw MoyaError.jsonMapping(self)
        }
        guard let object = T.deserialize(from: jsonStr) else {
            throw MoyaError.jsonMapping(self)
        }
        print(object)
        
        return object
    }

    // 将Json解析为多个Model，返回数组，对于不同的json格式需要对该方法进行修改
    public func mapArray<T:HandyJSON>(_ type: T.Type) throws -> [T] {

        guard let json = try mapJSON() as? [String : Any] else {
            throw MoyaError.jsonMapping(self)
        }

        guard let jsonArr = (json["result"] as? [String : Any]) else {
            throw MoyaError.jsonMapping(self)
        }

        guard let itemsArr = (jsonArr["list"] as? [[String : Any]]) else {
                 throw MoyaError.jsonMapping(self)
        }

        return   itemsArr.compactMap {T.deserialize(from: $0)}
    }
}

// MARK: - Json -> Observable<Model>
extension ObservableType where E == Response {
    // 将Json解析为Observable<Model>
    public func mapObject<T: HandyJSON>(_ type: T.Type) -> Observable<T> {

        return flatMap { response -> Observable<T> in

            return Observable.just(try response.mapObject(T.self))
        }
    }
    // 将Json解析为Observable<[Model]>
    public func mapArray<T: HandyJSON>(_ type: T.Type) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(T.self))
        }
    }
}
