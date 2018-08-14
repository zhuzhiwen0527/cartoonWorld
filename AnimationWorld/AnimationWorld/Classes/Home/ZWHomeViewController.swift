//
//  ZWHomeViewController.swift
//  AnimationWorld
//
//  Created by zzw on 2018/8/12.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Then
import SnapKit
import NSObject_Rx
import YYCategories
import YYText
class ZWHomeViewController: ZWBaseViewController {

    let viewModel = ZWHomeViewModel()
    let layout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = 10
        $0.minimumInteritemSpacing = 10
        $0.headerReferenceSize = CGSize(width:W , height: 200.0)
        $0.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        let w  = (W-50)/2.0
        $0.itemSize = CGSize(width: w, height: 100.0)
    }

    var collectionView:UICollectionView?

    var barView:UIView?
    var searchBar:UITextField?


    let dataSource = RxCollectionViewSectionedReloadDataSource<ZWSection>(configureCell:  { (ds, cv, ip, item) -> UICollectionViewCell in
        let cell = cv.dequeueReusableCell(for: ip) as ZWHomeCollectionViewCell
        cell.model = item
        return cell

    },configureSupplementaryView:{ (ds, cv, kind, ip) -> UICollectionReusableView in
        
        let view = cv.dequeueReusableSupplementaryView(ofKind: kind, for: ip) as ZWHomeHeaderCollectionReusableView
        return view

    })


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

    }
}
extension ZWHomeViewController{

  override  func addSubViews(){


    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    view.addSubview(collectionView!)
    collectionView?.backgroundColor = UIColor.white
    collectionView?.register(cellType: ZWHomeCollectionViewCell.self)
    collectionView?.register(supplementaryViewType: ZWHomeHeaderCollectionReusableView.self, ofKind: UICollectionElementKindSectionHeader)
    let tabbarHeight = self.tabBarController?.tabBar.frame.height
    print(tabbarHeight as Any)
    collectionView?.snp.makeConstraints({ (maker) in
        maker.edges.equalTo(view).inset(ConstraintInsets(top: 0, left: 0, bottom: tabbarHeight!, right: 0))
    })
        setNavi()
    }

    override  func bindView(){

        let homeInput = ZWHomeViewModel.ZWInput(name: "首页")
        let homeOutput = viewModel.transform(input: homeInput)
        homeOutput.requestCommond.onNext(true)
        homeOutput.sections.asDriver().drive(collectionView!.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)

        collectionView?.rx.itemSelected.subscribe(onNext: { IndexPath in
            print(IndexPath.row)
        }).disposed(by: rx.disposeBag)

        collectionView?.rx.didScroll.subscribe({ [weak self] _ in
            let offset = self?.collectionView?.contentOffset.y;
            let alpha = offset! / 200.0;
            self?.barView?.alpha = alpha;
            self?.searchBar?.backgroundColor = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: alpha)
        }).disposed(by: rx.disposeBag)
    }

    func setNavi(){

        let  sf = UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height)!
        print(sf)
        fd_prefersNavigationBarHidden = true
        barView = UIView().then({
            $0.alpha = 0.0
            $0.backgroundColor = UIColor.color(r: 255, g: 85, b: 153, a: 1)
            view.addSubview($0)
            $0.snp.makeConstraints({ (make) in
                make.top.equalTo(view)
                make.left.right.equalTo(view)
                make.height.equalTo(sf)
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
            view.addSubview($0)
            $0.snp.makeConstraints({ (make) in
                make.left.equalTo(40)
                make.right.equalTo(-40)
                make.height.equalTo(30)
                make.bottom.equalTo((barView?.snp.bottom)!).offset(-7)
            })
        }

    }

}
extension ZWHomeViewController:UICollectionViewDelegate{

}
extension ZWHomeViewController:UITextFieldDelegate{

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("跳转")
        return false
    }

}
