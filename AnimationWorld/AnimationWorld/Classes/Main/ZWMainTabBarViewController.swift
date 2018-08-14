//
//  ZWMainTabBarViewController.swift
//  AnimationWorld
//
//  Created by zzw on 2018/8/12.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import CYLTabBarController
class ZWMainTabBarViewController: CYLTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    static  func creatTabBarVC() -> ZWMainTabBarViewController {
        let  tabBar = UITabBarItem.appearance()
        tabBar.setTitleTextAttributes([.foregroundColor : UIColor.color(r: 65, g: 76, b: 110, a: 0.5)], for: .normal)
        tabBar.setTitleTextAttributes([.foregroundColor : UIColor.color(r: 65, g: 76, b: 110, a: 1)], for: .selected)

        return ZWMainTabBarViewController(viewControllers: ZWMainTabBarViewController.viewControllers(),
                                          tabBarItemsAttributes: ZWMainTabBarViewController.tabBarItemsAttributesForController())
    }


    static func viewControllers() -> [UINavigationController] {
        let homeVC = UINavigationController(rootViewController: ZWHomeViewController())
        let videoVC = UINavigationController(rootViewController: ZWVideoViewController())
        let meVC = UINavigationController(rootViewController: ZWMeViewController())
        return[homeVC,videoVC,meVC]
    }


    static  func tabBarItemsAttributesForController() -> [[String:String]] {
        let home = [CYLTabBarItemTitle:"首页",
                       CYLTabBarItemImage:"tabbar_home",
                       CYLTabBarItemSelectedImage:"tabbar_home_selected"]
        let video = [CYLTabBarItemTitle:"视频",
                       CYLTabBarItemImage:"tabbar_attention",
                       CYLTabBarItemSelectedImage:"tabbar_attention_selected"]
        let me = [CYLTabBarItemTitle:"我的",
                       CYLTabBarItemImage:"tabbar_profile",
                       CYLTabBarItemSelectedImage:"tabbar_profile_selected"]

        return [home,video,me]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
