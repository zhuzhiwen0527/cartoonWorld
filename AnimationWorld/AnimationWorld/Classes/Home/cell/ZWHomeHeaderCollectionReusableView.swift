//
//  ZWHomeHeaderCollectionReusableView.swift
//  AnimationWorld
//
//  Created by zzw on 2018/8/14.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
class ZWHomeHeaderCollectionReusableView: UICollectionReusableView ,Reusable{

    var hostBtn:UIButton?
    var newBtn:UIButton?
    var overBtn:UIButton?
    var cocorBtn:UIButton?
    var banner:UIImageView?
    var subject:PublishSubject<String>?
    var searchBar:UITextField?

    override init(frame:CGRect) {
        super.init(frame: frame)
        setUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUI(){
        banner = UIImageView().then({
            $0.contentMode = .scaleAspectFill
            $0.backgroundColor = UIColor.gray
            addSubview($0)
            $0.snp.makeConstraints({ (make) in
                make.top.right.left.equalToSuperview()
                make.height.equalTo(270)
            })
        })

        searchBar = UITextField().then {

            $0.layer.cornerRadius = 15
            $0.layer.masksToBounds = true
            $0.backgroundColor = UIColor.clear
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.borderWidth = 1
            let att = NSMutableAttributedString(string: "搜索")
            att.yy_color = UIColor.color(r: 65, g: 76, b: 110, a: 1)
            att.yy_font = UIFont.systemFont(ofSize: 12)
            $0.attributedPlaceholder = att
            $0.textAlignment = .center
            $0.delegate = self
            addSubview($0)

            $0.snp.makeConstraints({ (make) in
                make.left.equalTo(40)
                make.right.equalTo(-40)
                make.height.equalTo(30)
                make.top.equalTo(NAVIHEIGHT - 7 - 30)
            })
        }

        hostBtn = UIButton().then({
            $0.setTitle("热门", for: .normal)
            $0.setTitleColor(UIColor.color(r: 51, g: 51, b: 51, a: 1), for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            $0.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: {[weak self] _ in
                self?.subject?.onNext("热门")
            }).disposed(by: rx.disposeBag)
            addSubview($0)
        })
       newBtn = UIButton().then({
            $0.setTitle("最新", for: .normal)
            $0.setTitleColor(UIColor.color(r: 51, g: 51, b: 51, a: 1), for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: {[weak self] _ in
            self?.subject?.onNext("最新")
        }).disposed(by: rx.disposeBag)
            addSubview($0)
        })
        overBtn = UIButton().then({
            $0.setTitle("完结", for: .normal)
            $0.setTitleColor(UIColor.color(r: 51, g: 51, b: 51, a: 1), for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            $0.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: {[weak self] _ in
                self?.subject?.onNext("完结")
            }).disposed(by: rx.disposeBag)
            addSubview($0)
        })
        cocorBtn = UIButton().then({
            $0.setTitle("彩漫", for: .normal)
            $0.setTitleColor(UIColor.color(r: 51, g: 51, b: 51, a: 1), for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            $0.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: {[weak self] _ in
                self?.subject?.onNext("彩漫")
            }).disposed(by: rx.disposeBag)
            addSubview($0)
        })
        let views = [hostBtn,newBtn,overBtn,cocorBtn]

        views.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: 5, leadSpacing: 5, tailSpacing: 5)
        views.snp.makeConstraints{
            $0.top.equalTo((banner?.snp.bottom)!)
            $0.height.equalTo(30)
        }
    }


}

extension ZWHomeHeaderCollectionReusableView:UITextFieldDelegate{

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {

        subject?.onNext("跳转")
        return false
    }
}
