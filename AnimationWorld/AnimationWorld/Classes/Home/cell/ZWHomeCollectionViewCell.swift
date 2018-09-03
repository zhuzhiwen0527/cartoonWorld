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
    var nameLab:UILabel?
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
            nameLab?.text = model.title
            titleLab?.text = model.recentsection
        }
    }

    func setUI(){
        imgView = UIImageView().then({
            $0.contentMode = .scaleAspectFit
            contentView.addSubview($0)
        })
        titleLab = UILabel().then({
            $0.textColor = UIColor.color(r: 255, g: 255, b: 255, a: 0.8)
            $0.numberOfLines = 0
            $0.backgroundColor = UIColor(displayP3Red: 0.5, green: 0.6, blue: 07, alpha: 0.5)
            $0.font = UIFont.systemFont(ofSize: 14)
            contentView.addSubview($0)
            $0.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        })
        nameLab = UILabel().then({
            $0.textColor = UIColor.color(r: 51, g: 51, b: 51, a: 1)
            $0.font = UIFont.systemFont(ofSize: 14)
            contentView.addSubview($0)
        })
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        imgView?.snp.makeConstraints({ (maker) in
            maker.top.equalTo(contentView)
            maker.left.equalTo(contentView)
            maker.right.equalTo(contentView)
            maker.height.equalTo(contentView.width/3*4)
        })
        titleLab?.snp.makeConstraints({ (make) in
            make.bottom.equalTo((imgView?.snp.bottom)!)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
        })
        nameLab?.snp.makeConstraints({ (make) in
            make.top.equalTo((imgView?.snp.bottom)!)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.bottom.equalTo(contentView)
        })
    }
}
