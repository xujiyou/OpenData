//
//  NewsViewController.swift
//  OpenData
//
//  Created by jiyou xu on 2019/4/5.
//  Copyright © 2019 jiyou xu. All rights reserved.
//

import UIKit
import SnapKit

class NewsViewController: UIViewController {
    
    var shadowImage: UIImage?
    
    lazy var paperTabView = {
        return PaperTabView(frame: CGRect(x: 0, y: 0, width: self.view.width(), height: self.view.height()))
    }()
    
    lazy var vcArray:[UIViewController] = {
        var vcArray:[UIViewController] = []
        
        let one = UIViewController()
        one.title = "ONE"
        vcArray.append(one)
        
        let two = UIViewController()
        two.title = "TWO"
        vcArray.append(two)
        
        let three = UIViewController()
        three.title = "THREE"
        vcArray.append(three)
        
        return vcArray
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "新闻头条"
        self.view.backgroundColor = UIColor.white
        
        paperTabView.delegate = self
        paperTabView.buildUI()
        paperTabView.selectTabWithIndex(index: 0, animate: false)
        self.view.addSubview(paperTabView)
        paperTabView.snp_makeConstraints({make in
            make.left.top.right.bottom.equalToSuperview()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.shadowImage = nil
    }

}

extension NewsViewController: PaperTabViewDelegate {
    
    func numberOfPagers(view: PaperTabView) -> Int {
        return vcArray.count
    }
    
    func pagerViewOfPagers(view: PaperTabView, indexOfPagers: Int) -> UIViewController {
        return vcArray[indexOfPagers]
    }
    
    func whenSelectOnPager(number: Int) {
        print("页面\(number)被选中")
    }
    
    
}
