//
//  MainTabBarController.swift
//  LivingApplication
//
//  Created by ioser on 17/5/14.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor.orangeColor()

        createViewControllers("Home")
        createViewControllers("live")
        createViewControllers("follow")
        createViewControllers("Profile")
        
        
    }

    func createViewControllers(storyboardName : String) -> Void {
          // 通过storeboard加载控制器
        let viewController = UIStoryboard(name: storyboardName,bundle: nil).instantiateInitialViewController()
        
        addChildViewController(viewController!)
    }
}
