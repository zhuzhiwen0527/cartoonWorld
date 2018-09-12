//
//  ZWCartoonInfoViewController.swift
//  AnimationWorld
//
//  Created by zzw on 2018/8/16.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Then
import SnapKit
import NSObject_Rx
class ZWCartoonInfoViewController: ZWBaseViewController {

    var model:homeModel?
    let viewModel = ZWCartoonInfoViewModel()
    let tableView = UITableView().then {
        $0.rowHeight = UITableViewAutomaticDimension
        $0.register(cellType: ZWCommentTableViewCell.self)
        $0.separatorStyle = .none
    }
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
        headerView.model = self.model!
        tableView.tableHeaderView = headerView;
        headerView.rightBtn.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] in
//            print(self?.viewModel.chapterModesls)
        }).disposed(by: rx.disposeBag)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

    }

    override func bindView() {

        let dataSource = RxTableViewSectionedReloadDataSource<ZWCartoonInfoSection>(configureCell: {
            ds, tv, ip, item in

            let cell = tv.dequeueReusableCell(for: ip) as ZWCommentTableViewCell
            cell.model = item
            return cell
        })

        let input = ZWCartoonInfoViewModel.ZWInput(comment: "http://fuciyuanmobile.biaoqingdou.com//commentlist?work="+(self.model?.id)!+"&type=0&pagesize=30&pagenum=1&ver=2.1.3&plat=ip&channel=appstore&app=FuCiYuan",
                                                   chapter: "http://fuciyuanjson.biaoqingdou.com/fuciyuan/v1/sections/"+(self.model?.id)!+".json?ver=2.1.3&plat=ip&channel=appstore&app=FuCiYuan")
        let output = viewModel.transform(input: input)

        output.requestCommond.onNext(true)
        output.requestChapter.onNext(true)
        output.sections.asDriver().drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)

    }

}
