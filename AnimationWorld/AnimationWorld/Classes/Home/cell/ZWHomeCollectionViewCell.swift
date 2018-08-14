//
//  ZWHomeCollectionViewCell.swift
//  AnimationWorld
//
//  Created by zzw on 2018/8/13.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher
class ZWHomeCollectionViewCell: UICollectionViewCell ,Reusable{
    var imgView :UIImageView?
    var titleLab:UILabel?

    override init(frame:CGRect) {
        super.init(frame: frame)
        setUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var model = homeModel(){
        didSet{
            imgView?.kf.setImage(with: ImageResource(downloadURL:URL(string: model.img)!))
            titleLab?.text = model.title
        }
    }

    func setUI(){
        imgView = UIImageView().then({
            $0.contentMode = .scaleAspectFit
            contentView.addSubview($0)
            $0.snp.makeConstraints({ (maker) in
                maker.top.equalTo(contentView)
                maker.left.equalTo(contentView)
                maker.bottom.equalTo(contentView)
                maker.right.equalTo(contentView)
            })
        })
        titleLab = UILabel().then({
            $0.textColor = UIColor.red
            $0.numberOfLines = 0
            $0.backgroundColor = UIColor(displayP3Red: 0.5, green: 0.6, blue: 07, alpha: 0.5)
            contentView.addSubview($0)
            $0.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
            $0.snp.makeConstraints({ (make) in
                make.bottom.equalTo(contentView)
                make.left.equalTo(contentView)
                make.right.equalTo(contentView)
            })
        })
    }
}
