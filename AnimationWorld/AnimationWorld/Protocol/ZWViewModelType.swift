//
//  ZWViewModelType.swift
//  AnimationWorld
//
//  Created by zzw on 2018/8/13.
//  Copyright © 2018年 zzw. All rights reserved.
//

import Foundation
protocol ZWViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
