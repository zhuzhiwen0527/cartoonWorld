//
//  ZWHomeModel.swift
//  AnimationWorld
//
//  Created by zzw on 2018/8/13.
//  Copyright © 2018年 zzw. All rights reserved.
//

import Foundation
import HandyJSON
import RxDataSources
struct homeModel:HandyJSON {
 /*   "updatetime": "2018-08-11",
    "sectionlisturl": "102049.json",
    "img": "http://fuciyuanimg.biaoqingdou.com/works/9/102049.jpg",
    "author": " ",
    "title": "拯救自己的时间",
    "recentsection": "后记",
    "finished": "1",
    "score": "9.88888",
    "level": "2",
    "id": "102049"
 */
    var updatetime = ""
    var sectionlisturl = ""
    var img = ""
    var author = ""
    var title = ""
    var recentsection = ""
    var finished = ""
    var score = ""
    var level = ""
    var id = ""

}
/* ============================= SectionModel =============================== */

struct ZWSection {
    var imgUlr = ""
    var items: [Item]
}

extension ZWSection: SectionModelType {

    typealias Item = homeModel

    init(original: ZWSection, items: [ZWSection.Item]) {
        self = original
        self.items = items
    }
}
