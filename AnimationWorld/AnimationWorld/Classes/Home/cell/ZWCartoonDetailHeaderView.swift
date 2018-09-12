//
//  ZWCartoonDetailHeaderView.swift
//  AnimationWorld
//
//  Created by zzw on 2018/8/26.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher
import RxSwift
class ZWCartoonDetailHeaderView: UIView, NibLoadable{

    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var nicknameLab: UILabel!
    @IBOutlet weak var autorNameLab: UILabel!
    @IBOutlet weak var cartoongerneLab: UILabel!
    @IBOutlet weak var updateTimeLab: UILabel!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var model = homeModel(){
        didSet{

            imgV.kf.setImage(with: ImageResource(downloadURL:URL(string: model.img)!))
            nicknameLab.text = model.title
            autorNameLab.text = model.author
            cartoongerneLab.text = model.level
            updateTimeLab.text = model.updatetime
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        leftBtn.layer.cornerRadius = 4;
        leftBtn.layer.borderColor = UIColor.color(r: 61, g: 30, b: 255, a: 1).cgColor
        leftBtn.layer.borderWidth = 0.5

        rightBtn.layer.cornerRadius = 4;
        rightBtn.layer.borderColor = UIColor.color(r: 61, g: 30, b: 255, a: 1).cgColor
        rightBtn.layer.borderWidth = 0.5

    }

    override func layoutSubviews() {
        self.frame = CGRect(x: 0, y: 0, width: W, height: 190)
    }

}
