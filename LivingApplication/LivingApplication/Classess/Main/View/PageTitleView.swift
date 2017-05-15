//
//  PageTitleView.swift
//  LivingApplication
//
//  Created by ioser on 17/5/15.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit

protocol pageTitleViewDelegate : class {
    func pageLabelClick(selectIndext : Int, titleView : PageTitleView)
}

class PageTitleView: UIView {
        /// 懒加载
    lazy var labelArray : [UILabel] = [UILabel]()
    
    lazy var scrollview : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    lazy var scrollerLine : UIView = {
        let scrollerLine = UIView()
        scrollerLine.backgroundColor = UIColor.orangeColor()
        return scrollerLine
    }()
    
        /// 私有属性
    private var titles : [String]
    private var currentIndext : Int = 0
    weak var delegate : pageTitleViewDelegate?
    
    
//构造方法
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        // 设置UI界面
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 扩展方法
extension PageTitleView{
    /**
     UI设计
     */
    private func setUI(){
      // 1 添加scrollView
        self.scrollview.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        addSubview(self.scrollview)
        
      // 2 添加label
        let labelW = self.scrollview.frame.size.width / CGFloat(titles.count)
        let labelH = self.scrollview.frame.size.height
        let labelY : CGFloat = 0
        
        for(indext,title) in self.titles.enumerate() {
            let label = UILabel()
            label.text = title
            label.tag = indext
            label.textAlignment = .Center
            label.textColor = UIColor.lightGrayColor()
            let labelX = CGFloat(indext) * labelW
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            self.scrollview.addSubview(label)
            self.labelArray.append(label)
            label.userInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapClick(_:)))
            label.addGestureRecognizer(tapGesture)
        }
        
        // 3 添加bottomLine
        let bottomLine = UIView()
        let x : CGFloat = 0
        let w = frame.size.width
        let h : CGFloat = 1
        let y = frame.size.height - h
        bottomLine.backgroundColor = UIColor.lightGrayColor()
//        addSubview(bottomLine)
        bottomLine.frame = CGRect(x: x, y: y, width: w, height: h)
        
        // 4添加ScollerLine
        setScrollerLine()
    }
    /**
     *  设置滚动指示条
     */
    private func setScrollerLine(){
        guard let firstLabel : UILabel = labelArray.first else { return }
        firstLabel.textColor = UIColor.orangeColor()
//        let line = UIView()
        scrollerLine.backgroundColor = UIColor.orangeColor()
        self.scrollview.addSubview(scrollerLine)
        let lineH : CGFloat = 2
        
        scrollerLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.size.height - lineH - 1, width: firstLabel.frame.size.width, height: lineH)
        
        
    }
}

// MARK: - label点击事件
extension PageTitleView{
    
    @objc private func labelTapClick(tap : UITapGestureRecognizer){
        guard let selectLable = tap.view as? UILabel else {return}
        selectLable.textColor = UIColor.orangeColor()
        
        let oldLabel = self.labelArray[self.currentIndext]
        self.currentIndext = selectLable.tag
        oldLabel.textColor = UIColor.lightGrayColor()
        UIView.animateWithDuration(0.25) { [weak self] in
            self!.scrollerLine.frame.origin.x = selectLable.frame.origin.x
        }
//        scrollerLine.frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        
        delegate?.pageLabelClick(currentIndext, titleView: self)
    }
}









