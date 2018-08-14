//
//  ZWHomeHeaderCollectionReusableView.swift
//  AnimationWorld
//
//  Created by zzw on 2018/8/14.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import Reusable
class ZWHomeHeaderCollectionReusableView: UICollectionReusableView ,Reusable{
    override init(frame:CGRect) {
        super.init(frame: frame)
        setUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUI(){
        backgroundColor = UIColor.red
    }


}
