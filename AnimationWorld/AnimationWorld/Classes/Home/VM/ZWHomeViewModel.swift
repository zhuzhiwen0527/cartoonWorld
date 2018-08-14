//
//  ZWHomeViewModel.swift
//  AnimationWorld
//
//  Created by zzw on 2018/8/13.
//  Copyright © 2018年 zzw. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum ZWRefreshStatus {
    case none
    case endRefresh
    case noMoreData
}


class ZWHomeViewModel: NSObject {
    let models = Variable<[homeModel]>([])
}
extension ZWHomeViewModel :ZWViewModelType{


    typealias Output = ZWOutput
    typealias Input = ZWInput


    struct ZWInput {
        // 传递参数

        var name = ""
        init(name:String) {
            self.name = name
        }
    }

    struct ZWOutput {
        // tableView的sections数据
        let sections: Driver<[ZWSection]>
        // 外界通过该属性告诉viewModel加载数据（传入的值是为了标志是否重新加载）
        let requestCommond = PublishSubject<Bool>()
        var index:Int = 0
        // 告诉外界的tableView当前的刷新状态
        let refreshStatus = Variable<ZWRefreshStatus>(.none)
        init(sections: Driver<[ZWSection]>) {
            self.sections = sections
        }
    }

    func transform(input: ZWHomeViewModel.ZWInput) -> ZWHomeViewModel.ZWOutput {

        let sections = models.asObservable().map { (items) -> [ZWSection] in
            // 当models的值被改变时会调用

            return [ZWSection(items: items)]
            }.asDriver(onErrorJustReturn: [])

        print(input.name)

        var output = ZWOutput(sections: sections)

        output.requestCommond.subscribe(onNext: {[unowned self] isReloadData in

            zwNetTool.rx.request(.home).asObservable().mapArray(homeModel.self).subscribe({ [weak self] (event) in
                switch event {
                case let .next(modelArr):
                    output.index =  isReloadData ? 0 :  output.index + 1
             
                    self?.models.value = isReloadData ? modelArr : (self?.models.value ?? []) + modelArr
                    modelArr.count == 0 ? (output.refreshStatus.value = .noMoreData) :  (output.refreshStatus.value = .endRefresh)

                case .error(_):
                    output.refreshStatus.value = .endRefresh
                case .completed:break

                }
            }).disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)

        return output
    }
}



