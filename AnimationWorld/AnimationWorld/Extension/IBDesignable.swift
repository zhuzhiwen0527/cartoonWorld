//
//  IBDesignable.swift
//  AnimationWorld
//
//  Created by zzw on 2019/9/18.
//  Copyright © 2019 zzw. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {

   @IBInspectable var adapterScreen:Bool {

        get{
            return true
        }
        set{
            if adapterScreen {
                self.constant = self.constant*0.5
            }
        }

    }
}

extension UIView {

    @IBInspectable var cornerRadius:CGFloat{

        get{
            print(layer.cornerRadius)
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
}
