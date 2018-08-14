//
//  UIColor+Extension.swift
//  AnimationWorld
//
//  Created by zzw on 2018/8/14.
//  Copyright © 2018年 zzw. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {

    class func color(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor{
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
}
