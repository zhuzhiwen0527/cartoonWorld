//
//  ValidationError.swift
//  AnimationWorld
//
//  Created by zzw on 2018/8/12.
//  Copyright © 2018年 zzw. All rights reserved.
//

import Foundation

public protocol ValidationErrorType: Error {
    var message: String { get }
}

public struct ValidationError: ValidationErrorType {

    public let message: String

    public init(message m: String) {
        message = m
    }

}
