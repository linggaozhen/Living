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
    lazy var contentView : pageContentView = {[weak self] in
        // 通过一个数组保存控制器
        var controllerArray = [UIViewController]()
        let recommerController = RecommerController()
        controllerArray.append(recommerController)
        for i in 0...2 {
          let viewController = UIViewController()
            viewController.view.backgroundColor = UIColor.init(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            controllerArray.append(viewController)
        }
        // 初始化contentView，把数组传进去
        let contentView = pageContentView(frame: (self?.view.bounds)!, childViewController: controllerArray, parentController: self!)
        
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
        // 1 设置导航栏
        setNavigationItem()
        
        // 2 设置titleView
        setTitleView()
        
        // 3 设置contentView
        setcontentView()
        
     
    }
    
   
    
    /**
     setTitleView
     */
    private func setTitleView(){
        view.addSubview(self.pageTitleView)
    }
    
    private func setcontentView(){
        let contentViewY = self.pageTitleView.frame.maxY
        
        contentView.frame = CGRect(x: 0, y: contentViewY, width: KScreenW, height: KScreenH - contentViewY - 44)
        contentView.scrollerDelegate = self
        contentView.backgroundColor = UIColor.yellowColor()
        view.addSubview(contentView)
    }
    
    /**
     setNavigationItem
     */
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

// MARK: - titleView Label 的点击事件
extension HomeViewController : pageTitleViewDelegate{
    func pageLabelClick(selectIndext: Int, titleView: PageTitleView) {
        self.contentView.pageTitleLabelClick(selectIndext)
    }
}

// contentView的代理事件
extension HomeViewController : pageContentViewScrollerDelegate{

    func scrollerProgress(progress: CGFloat, beginIndext: Int, targetIndext: Int) {
//        print("begin \(beginIndext) target \(targetIndext) progress \(progress)")
        self.pageTitleView.changeLineFrameAndLabelColor(beginIndext, targetIndext: targetIndext, progress: progress)
    }
}


