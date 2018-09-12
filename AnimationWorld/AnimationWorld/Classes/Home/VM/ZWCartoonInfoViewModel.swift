//
//  ZWCartoonInfoViewModel.swift
//  AnimationWorld
//
//  Created by zzw on 2018/9/12.
//  Copyright © 2018年 zzw. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
class ZWCartoonInfoViewModel: NSObject {
    let models = Variable<[ZWCartoonInfoModel]>([])
    var chapterModesls = [ZWChapterModel]()
}

extension ZWCartoonInfoViewModel :ZWViewModelType{
    typealias Output = ZWOutput
    typealias Input = ZWInput
    class  ZWInput {
        // 传递参数

        var comment = ""
        var chapter = ""
        init(comment:String,chapter:String) {
            self.comment = comment
            self.chapter = chapter
        }
    }
    struct ZWOutput {
        // tableView的sections数据
        let sections: Driver<[ZWCartoonInfoSection]>
        // 外界通过该属性告诉viewModel加载数据（传入的值是为了标志是否重新加载）
        let requestCommond = PublishSubject<Bool>()
        let requestChapter = PublishSubject<Bool>()
        var index:Int = 0
        init(sections: Driver<[ZWCartoonInfoSection]>) {
            self.sections = sections
        }
    }
    func transform(input: ZWCartoonInfoViewModel.ZWInput) -> ZWCartoonInfoViewModel.ZWOutput {

        let sections = models.asObservable().map { (items) -> [ZWCartoonInfoSection] in
 
            return [ZWCartoonInfoSection(items: items)]
            }.asDriver(onErrorJustReturn: [])

        let output = ZWOutput(sections: sections)

        output.requestCommond.subscribe(onNext: {[unowned self] _ in

            zwNetTool.rx.request(.hostUrl(url:input.comment)).asObservable().mapArray(ZWCartoonInfoModel.self).subscribe({ [weak self] (event) in
                switch event {
                case let .next(modelArr):
    
                    self?.models.value = modelArr

                case .error(_): break
                
                case .completed:break

                }
            }).disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)

        output.requestChapter.subscribe(onNext: {[unowned self] _ in

            zwNetTool.rx.request(.hostUrl(url:input.chapter)).asObservable().mapObject(ZWChapterArrModel.self).subscribe({ [weak self] (event) in
                switch event {
                case let .next(model):
    
                self?.chapterModesls = model.sections

                case .error(_): break

                case .completed:break

                }
            }).disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)

        return output
    }
}
