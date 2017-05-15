//
//  HomeViewController.swift
//  LivingApplication
//
//  Created by ioser on 17/5/15.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupUI()
    }

}

extension HomeViewController{
    
    private func setupUI() -> Void {
        setNavigationItem()
    }
    
    private func setNavigationItem(){
    
        
        // 左边item
//        let leftItem = UIBarButtonItem.createBarButtonItem("logo")
        let leftItem = UIBarButtonItem(imageName: "logo")
        
        navigationItem.leftBarButtonItem = leftItem
        
        // 右边item
        let size = CGSizeMake(40, 40)
        
        // 利用构造函数创建
        let historyItem = UIBarButtonItem(imageName: "image_my_history", hightImageName: "image_my_history_click", size: size)
        let qrCoderItem = UIBarButtonItem(imageName: "Image_scan", hightImageName: "Image_scan_click", size: size)
        let SearchItem = UIBarButtonItem(imageName: "btn_search", hightImageName: "btn_search_clicked", size: size)
        
        
        navigationItem.rightBarButtonItems = [historyItem,qrCoderItem,SearchItem]
        
        
    }
}






