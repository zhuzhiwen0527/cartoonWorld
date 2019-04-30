//
//  ZWBaseViewController.swift
//  AnimationWorld
//
//  Created by zzw on 2018/8/12.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit

class ZWBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        tabBarController?.tabBar.isTranslucent = false
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        self.addSubViews()
        self.bindView()
        
        if (navigationController?.viewControllers.count)! > 1 {
            navigationItem.leftBarButtonItem = leftBarItem()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
extension ZWBaseViewController{

    
    @objc  func addSubViews(){


    }

    @objc  func bindView(){

    }


    func leftBarItem() -> UIBarButtonItem {
        let leftBarItem = UIBarButtonItem(image: UIImage(named: "arrowBack"), style: .plain, target: self, action: #selector(back))
        return leftBarItem
    }
    @objc func back()   {
        navigationController?.popViewController(animated: true)
    }
}
