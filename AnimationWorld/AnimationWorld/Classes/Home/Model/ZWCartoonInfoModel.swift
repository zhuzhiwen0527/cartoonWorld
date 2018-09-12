//
//  ZWCartoonInfoModel.swift
//  AnimationWorld
//
//  Created by zzw on 2018/9/12.
//  Copyright © 2018年 zzw. All rights reserved.
//

import Foundation
import Foundation
import HandyJSON
import RxDataSources
struct ZWCartoonInfoModel:HandyJSON {
    /*          "id": 0,
     "uid": 0,
     "user": "腐次元酱【置顶】",
     "userpic": "http://fuciyuanuserpic.biaoqingdou.com/user0.jpg",
     "content": "1、ios版腐次元已经上线，欢迎下载；2、开通会员有更多福利；3、漫画仅供试看，若侵权或不符合国家规定请点举报；",
     "prefer": 10000,
     "pubtime": "2016-05-01",
     "hot": 0,
     "reply": null
     */
    var reply = ""
    var hot = ""
    var pubtime = ""
    var prefer = ""
    var content = ""
    var userpic = ""
    var user = ""
    var score = ""
    var uid = ""
    var id = ""

}
/* ============================= SectionModel =============================== */

struct ZWCartoonInfoSection {
    var items: [Item]
}

extension ZWCartoonInfoSection : SectionModelType {

    typealias Item = ZWCartoonInfoModel
    init(original: ZWCartoonInfoSection, items: [ZWCartoonInfoSection.Item]) {
        self = original
        self.items = items
    }
}
