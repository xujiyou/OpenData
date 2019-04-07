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
        
        let top = NewsTableViewController()
        top.title = "头条"
        top.type = "top"
        top.navController = self.navigationController
        vcArray.append(top)
        
        let shehui = NewsTableViewController()
        shehui.title = "社会"
        shehui.type = "shehui"
        shehui.navController = self.navigationController
        vcArray.append(shehui)

        let guonei = NewsTableViewController()
        guonei.title = "国内"
        guonei.type = "guonei"
        guonei.navController = self.navigationController
        vcArray.append(guonei)

        let guoji = NewsTableViewController()
        guoji.title = "国际"
        guoji.type = "guoji"
        guoji.navController = self.navigationController
        vcArray.append(guoji)

        let yule = NewsTableViewController()
        yule.title = "娱乐"
        yule.type = "yule"
        yule.navController = self.navigationController
        vcArray.append(yule)

        let tiyu = NewsTableViewController()
        tiyu.title = "体育"
        tiyu.type = "tiyu"
        tiyu.navController = self.navigationController
        vcArray.append(tiyu)

        let junshi = NewsTableViewController()
        junshi.title = "军事"
        junshi.type = "junshi"
        junshi.navController = self.navigationController
        vcArray.append(junshi)

        let keji = NewsTableViewController()
        keji.title = "科技"
        keji.type = "keji"
        keji.navController = self.navigationController
        vcArray.append(keji)

        let caijing = NewsTableViewController()
        caijing.title = "财经"
        caijing.type = "caijing"
        caijing.navController = self.navigationController
        vcArray.append(caijing)

        let shishang = NewsTableViewController()
        shishang.title = "时尚"
        shishang.type = "shishang"
        shishang.navController = self.navigationController
        vcArray.append(shishang)
        
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
