//
//  HomeViewController.swift
//  LivingApplication
//
//  Created by ioser on 17/5/15.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    // titleView懒加载
    lazy var pageTitleView : PageTitleView = {
        let titleViewFrame = CGRect(x: 0, y: 64, width: KScreenW, height: 40)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleViewFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    // contentView 懒加载
    lazy var contentView : pageContentView = {
        let controller = UIViewController()
        
        let contentView = pageContentView(frame: CGRectZero, childViewController: [controller], parentController: self)
        return contentView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupUI()
    }

}

// 扩展方法
extension HomeViewController{
    
    private func setupUI() -> Void {
        automaticallyAdjustsScrollViewInsets = false
        // 设置导航栏
        setNavigationItem()
        
        // 设置titleView
        setTitleView()
        
        // 设置contentView
        setcontentView()
    }
    
    private func setTitleView(){
        view.addSubview(self.pageTitleView)
    }
    
    private func setcontentView(){
        let contentViewY = self.pageTitleView.frame.maxY
        
        contentView.frame = CGRect(x: 0, y: contentViewY, width: KScreenW, height: KScreenH - contentViewY)
        contentView.backgroundColor = UIColor.yellowColor()
        view.addSubview(contentView)
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


extension HomeViewController : pageTitleViewDelegate{
    func pageLabelClick(selectIndext: Int, titleView: PageTitleView) {
        print(selectIndext)
    }
}



