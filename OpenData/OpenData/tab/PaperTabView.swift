//
//  PaperTabView.swift
//  OpenData
//
//  Created by jiyou xu on 2019/4/6.
//  Copyright © 2019 jiyou xu. All rights reserved.
//

import UIKit

protocol PaperTabViewDelegate: NSObject {
    func numberOfPagers(view: PaperTabView) -> Int
    func pagerViewOfPagers(view: PaperTabView, indexOfPagers: Int) -> UIViewController
    func whenSelectOnPager(number: Int)
}

class PaperTabView: UIView, UIScrollViewDelegate {

    var delegate: PaperTabViewDelegate?
    
    var tabFrameHeight: CGFloat = 36 //头部tab高
    var tabBackgroundColor: UIColor = UIColor.white //头部tab背景颜色
    var tabButtonFontSize: CGFloat = 14 //头部tab按钮字体大小
    var tabMargin: CGFloat = 12 //头部tab左右两端和边缘的间隔
    var tabButtonTitleColorForNormal: UIColor = UIColor.black //未选中时按钮文字的颜色
    var tabButtonTitleColorForSelected: UIColor = UIColor.red //选中时按钮文字的颜色
    var selectedLineWidth: CGFloat = 42 //下划线的宽
    
    var isBuildUI: Bool = false
    var isUseDragging: Bool = false
    var isEndDecelerating: Bool = true
    var startOffsetX: CGFloat = 0
    var continueDraggingNumber: Int = 0
    
    var currentTabSelected: Int = 0
    var selectedLineOffsetXBeforeMoving: CGFloat = 0
    
    var viewsArray: [UIViewController] = []
    var tabButtons: [UIButton] = []
    var tabRedDots: [UIView] = [] //按钮上的红点
    
    lazy var tabView: UIView = {
        let tabView = UIView(frame: CGRect(x: 0, y: 0, width: self.width(), height: tabFrameHeight))
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: self.tabFrameHeight, width: self.width(), height: 0.4)
        bottomLayer.backgroundColor = UIColor(displayP3Red: 200 / 255, green: 200 / 255, blue: 200 / 255, alpha: 1.0).cgColor
        tabView.layer.addSublayer(bottomLayer)
        self.addSubview(tabView)
        return tabView
    }()
    
    lazy var selectedLine: UIView = {
        let line = UIView(frame: CGRect(x: 0, y: self.tabView.height() - 2, width: self.selectedLineWidth, height: 2))
        line.backgroundColor = UIColor.red
        self.addSubview(line)
        return line
    }()
    
    lazy var bodyScrollView: UIScrollView = {
        let bodyScrollView = UIScrollView(frame: CGRect(x: 0, y: tabFrameHeight, width: self.width(), height: self.height() - tabFrameHeight))
        bodyScrollView.delegate = self
        bodyScrollView.isPagingEnabled = true
        bodyScrollView.isUserInteractionEnabled = true
        bodyScrollView.bounces = false
        bodyScrollView.showsHorizontalScrollIndicator = false
        bodyScrollView.autoresizingMask = [.flexibleHeight, .flexibleBottomMargin, .flexibleWidth]
        self.addSubview(bodyScrollView)
        return bodyScrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        if isBuildUI {
            self.bodyScrollView.contentSize = CGSize(width: self.width() * CGFloat(self.viewsArray.count), height: self.tabFrameHeight)
            for i in 0...self.viewsArray.count - 1 {
                let vc = self.viewsArray[i]
                vc.view.frame = CGRect(x: self.bodyScrollView.width() * CGFloat(i), y: 0, width: self.bodyScrollView.width(), height: self.bodyScrollView.height())
            }
        }
    }
    
    func buildUI() {
        self.autoresizesSubviews = true
        let number = delegate!.numberOfPagers(view: self)
        for i in 0...number - 1 {
            //ScrollView部分
            let viewController = delegate!.pagerViewOfPagers(view: self, indexOfPagers: i)
            self.viewsArray.append(viewController)
            self.bodyScrollView.addSubview(viewController.view)
            
            //tab上按钮
            let itemButton = UIButton(type: .custom)
            let itemButtonWidth = (self.width() - self.tabMargin * 2) / CGFloat(number)
            itemButton.frame =
                CGRect(x: self.tabMargin + itemButtonWidth * CGFloat(i), y: 0, width: itemButtonWidth, height: self.tabFrameHeight)
            itemButton.titleLabel?.baselineAdjustment = .alignCenters
            itemButton.titleLabel?.font = UIFont.systemFont(ofSize: self.tabButtonFontSize)
            itemButton.setTitle(viewController.title, for: .normal)
            itemButton.setTitleColor(self.tabButtonTitleColorForNormal, for: .normal)
            itemButton.setTitleColor(self.tabButtonTitleColorForSelected, for: .selected)
            itemButton.addTarget(self, action: #selector(onTabButtonSelected), for: .touchUpInside)
            itemButton.tag = i
            self.tabButtons.append(itemButton)
            self.tabView.addSubview(itemButton)
            
            //tab上的红点
            let aRedDot = UIView(frame: CGRect(
                x: itemButton.width() / 2 + self.buttonTitleRealSize(button: itemButton).width / 2 + 3,
                y: itemButton.height() / 2 - self.buttonTitleRealSize(button: itemButton).height / 2,
                width: 8, height: 8))
            aRedDot.backgroundColor = UIColor.red
            aRedDot.layer.cornerRadius = aRedDot.width() / 2
            aRedDot.layer.masksToBounds = true
            aRedDot.isHidden = true
            self.tabRedDots.append(aRedDot)
            itemButton.addSubview(aRedDot)
        }
        self.tabView.backgroundColor = self.tabBackgroundColor
        isBuildUI = true
        self.setNeedsLayout()
    }
    
    func buttonTitleRealSize(button: UIButton) -> CGSize {
        return (button.titleLabel?.text!.size(withAttributes: [NSAttributedString.Key.font: button.titleLabel!.font!]))!
    }
    
    @objc func onTabButtonSelected(button: UIButton) {
        self.selectTabWithIndex(index: button.tag, animate: true)
    }
    
    func selectTabWithIndex(index: Int, animate: Bool) {
        let preButton = self.tabButtons[self.currentTabSelected]
        preButton.isSelected = false
        let currentButton = self.tabButtons[index]
        currentButton.isSelected = true
        currentTabSelected = index
        
        func moveSelectedLine() {
            self.selectedLine.center = CGPoint(x: currentButton.center.x, y: currentButton.height());
            self.selectedLineOffsetXBeforeMoving = self.selectedLine.origin().x
        }
        
        //移动select line
        if animate {
            UIView.animate(withDuration: 0.3, animations: moveSelectedLine)
        } else {
            moveSelectedLine()
        }
        
        self.switchWithIndex(index: index, animate: animate)
        self.delegate!.whenSelectOnPager(number: index)
    }
    
    func moveSelectedLineByScrollWithOffsetX(offsetX: CGFloat) {
        let zoneWidth = self.width() - self.tabMargin * 2.0 - self.selectedLine.width() * CGFloat(self.tabButtons.count)
        let textGap = zoneWidth / CGFloat(self.tabButtons.count * 2);
        let speed: CGFloat = 50
        //移动的距离
        let movedFloat = self.selectedLineOffsetXBeforeMoving + (offsetX * (textGap + self.selectedLine.width() + speed)) / UIScreen.main.bounds.size.width
        //最大右移值
        let selectedLineRightBarrier = self.selectedLineOffsetXBeforeMoving + textGap * 2 + self.selectedLine.width()
        //最大左移值
        let selectedLineLeftBarrier = self.selectedLineOffsetXBeforeMoving - textGap * 2 - self.selectedLine.width();
        
        var selectedLineNewX: CGFloat = 0
        var isContinueDragging = false
        if continueDraggingNumber > 1 {
            isContinueDragging = true
        }
        
        if movedFloat > selectedLineRightBarrier && !isContinueDragging {
            //右慢拖动设置拦截
            selectedLineNewX = selectedLineRightBarrier;
        } else if movedFloat < selectedLineLeftBarrier && !isContinueDragging {
            //左慢拖动设置的拦截
            selectedLineNewX = selectedLineLeftBarrier;
        } else {
            //连续拖动可能超过总长的情况需要拦截
            if isContinueDragging {
                if (movedFloat > self.width() - (self.tabMargin + textGap + self.selectedLine.width())) {
                    selectedLineNewX = self.width() - (self.tabMargin + textGap + self.selectedLine.width());
                } else if (movedFloat < self.tabMargin + textGap) {
                    selectedLineNewX = self.tabMargin + textGap;
                } else {
                    selectedLineNewX = movedFloat;
                }
            } else {
                //无拦截移动
                selectedLineNewX = movedFloat;
            }
        }
        self.selectedLine.frame = CGRect(x: selectedLineNewX, y: self.selectedLine.frame.origin.y, width: self.selectedLine.width(), height: self.selectedLine.height())
    }
    
    // #pragma mark - BodyScrollView 随按钮的点击而切换界面
    func switchWithIndex(index:Int, animate: Bool) {
        self.bodyScrollView.setContentOffset(CGPoint(x: CGFloat(index) * self.width(), y: 0), animated: animate)
        isUseDragging = false
    }
    
    // #pragma mark - ScrollView Delegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == bodyScrollView {
            continueDraggingNumber += 1
            if isEndDecelerating {
                startOffsetX = scrollView.contentOffset.x
            }
            isUseDragging = true
            isEndDecelerating = false
        }
    }
    
    /*!
     * @brief 对拖动过程中的处理
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == bodyScrollView {
            let movingOffsetX = scrollView.contentOffset.x - startOffsetX
            if isUseDragging {
                self.moveSelectedLineByScrollWithOffsetX(offsetX: movingOffsetX)
            }
        }
    }
    
    /*!
     * @brief 手释放后pager归位后的处理
     */
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == bodyScrollView {
            self.selectTabWithIndex(index: Int(scrollView.contentOffset.x / self.bounds.size.width), animate: true)
            isUseDragging = true
            isEndDecelerating = true
            continueDraggingNumber = 0
        }
    }
    
    /*!
     * @brief 自动停止
     */
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView == bodyScrollView {
            self.selectTabWithIndex(index: Int(scrollView.contentOffset.x / self.bounds.size.width), animate: true)
        }
    }
    
    
}
