//
//  ZWChapterModel.swift
//  AnimationWorld
//
//  Created by zzw on 2018/9/12.
//  Copyright © 2018年 zzw. All rights reserved.
//

import Foundation
import HandyJSON


struct ZWChapterArrModel :HandyJSON{
    /*
     */
    var sections = [ZWChapterModel]()
}
struct ZWChapterModel :HandyJSON{
    /*
     "piclisturl": "96/893496.json",
     "type": "0",
     "id": "893496",
     "picnum": "28",
     "title": "第2话"
     */

    var piclisturl = ""
    var type = ""
    var picnum = ""
    var title = ""
    var id = ""
    
}


