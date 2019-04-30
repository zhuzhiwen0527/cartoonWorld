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
import MJRefresh

class ZWHomeViewController: ZWBaseViewController {

    let viewModel = ZWHomeViewModel()
    let layout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = 5
        $0.minimumInteritemSpacing = 10
        $0.headerReferenceSize = CGSize(width:W , height: 210.0)
        $0.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        let w  = (W-30)/3.0
        $0.itemSize = CGSize(width: w, height: w/3*4 + 20)
    }
    var collectionView:UICollectionView?

    var barView:UIView?
    var searchBar:UITextField?

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
    collectionView?.snp.makeConstraints({ (maker) in
        maker.edges.equalTo(view).inset(ConstraintInsets(top: 0, left: 0, bottom: 0, right: 0))
    })

        setNavi()
    }

    override  func bindView(){

        let dataSource = RxCollectionViewSectionedReloadDataSource<ZWSection>(configureCell:  { (ds, cv, ip, item) -> UICollectionViewCell in
            let cell = cv.dequeueReusableCell(for: ip) as ZWHomeCollectionViewCell
            cell.model = item
            return cell

        },configureSupplementaryView:{ [weak self](ds, cv, kind, ip) -> UICollectionReusableView in

            let view = cv.dequeueReusableSupplementaryView(ofKind: kind, for: ip) as ZWHomeHeaderCollectionReusableView
            let modle =  ds.sectionModels[ip.section]
            view.imgUrl = modle.imgUlr
            view.subject = self?.viewModel.subject
            return view

        })

        let homeInput = ZWHomeViewModel.ZWInput(name:"http://fuciyuanjson.biaoqingdou.com/fuciyuan/v1/comichot_1.json?&ver=2.1.3&plat=ip&channel=appstore&app=FuCiYuan")
        let homeOutput = viewModel.transform(input: homeInput)

        homeOutput.requestCommond.onNext(true)

        homeOutput.sections.asDriver().drive(collectionView!.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)


        //  刷新事件
        collectionView?.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            homeOutput.requestCommond.onNext(true)
        })
        homeOutput.refreshStatus.asObservable().subscribe(onNext: {[weak self] status in
            switch status {
            case .endRefresh:
                self?.collectionView?.mj_header.endRefreshing()
            case .noMoreData:
                self?.collectionView?.mj_footer.endRefreshingWithNoMoreData()
            default:
                break
            }
        }).disposed(by: rx.disposeBag)

        //组视图 点击事件
        viewModel.subject.subscribe(onNext: {
   
            homeInput.name = $0
            homeOutput.requestCommond.onNext(true)

        }).disposed(by: rx.disposeBag)

        //点击事件

        collectionView?.rx.modelSelected(homeModel.self).subscribe(onNext: { [weak self]items in
           
          
            let vc = ZWCartoonInfoViewController()
            vc.model = items
            vc.hidesBottomBarWhenPushed = true
            self?.cyl_push(vc, animated: true)

        }).disposed(by: rx.disposeBag)

        collectionView?.rx.didScroll.subscribe({ [weak self] _ in
            let offset = self?.collectionView?.contentOffset.y;
            let alpha = offset! / 200.0;
            self?.barView?.alpha = alpha;
            self?.searchBar?.isHidden = alpha > 1 ? false : true
        }).disposed(by: rx.disposeBag)


    }

    func setNavi(){

        let  sf = UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height)!
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
            $0.backgroundColor = UIColor.white
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.borderWidth = 1
            let att = NSMutableAttributedString(string: "漫画名称/作者名称")
            att.yy_color = UIColor.color(r: 65, g: 76, b: 110, a: 1)
            att.yy_font = UIFont.systemFont(ofSize: 12)
            $0.attributedPlaceholder = att
            $0.textAlignment = .center
            $0.delegate = self
            $0.isHidden = true
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
extension ZWHomeViewController:UITextFieldDelegate{

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("跳转")
        return false
    }

}
