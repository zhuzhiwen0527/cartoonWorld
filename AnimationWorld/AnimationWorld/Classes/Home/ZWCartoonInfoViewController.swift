//
//  ZWCartoonInfoViewController.swift
//  AnimationWorld
//
//  Created by zzw on 2018/8/16.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit

class ZWCartoonInfoViewController: ZWBaseViewController {

    var model:homeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = model?.title
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
extension ZWCartoonInfoViewController {

    override func addSubViews() {
        let headerView = ZWCartoonDetailHeaderView.loadFromNib()
        view.addSubview(headerView)
        headerView.model = self.model!
        headerView.snp.makeConstraints({ (maker) in
            maker.top.equalTo(view)
            maker.left.equalTo(view)
            maker.right.equalTo(view)
            maker.height.equalTo(190)
        })

    }
}
