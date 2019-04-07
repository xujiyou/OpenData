//
//  ViewController.swift
//  OpenData
//
//  Created by jiyou xu on 2019/4/4.
//  Copyright © 2019 jiyou xu. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var shadowImage: UIImage?
    
    let identifier = "iconCell"
    
    let iconList = [
        IconModel(iconName: "one-news", title: "新闻头条", controller: NewsViewController()),
        IconModel(iconName: "two-phone", title: "手机号码归属地", controller: PhonePlaceViewController()),
        IconModel(iconName: "three-lottery", title: "彩票开奖结果", controller: NewsViewController()),
        IconModel(iconName: "four-weather", title: "天气预报", controller: NewsViewController()),
        IconModel(iconName: "five-ercode", title: "二维码生成", controller: NewsViewController()),
        IconModel(iconName: "six-exchange", title: "汇率", controller: NewsViewController()),
        IconModel(iconName: "seven-history", title: "历史上的今天", controller: NewsViewController()),
        IconModel(iconName: "eight-wechat", title: "微信精选", controller: NewsViewController()),
        IconModel(iconName: "nine-qq", title: "QQ号码测吉凶", controller: NewsViewController()),
        IconModel(iconName: "ten-joke", title: "笑话大全", controller: NewsViewController()),
        IconModel(iconName: "eleven-zidian", title: "新华字典", controller: NewsViewController()),
        IconModel(iconName: "fullup-chengyu", title: "成语词典", controller: NewsViewController()),
        IconModel(iconName: "twelve-change", title: "简/繁字体转换", controller: NewsViewController()),
        IconModel(iconName: "thirteen-youzheng", title: "邮编查询", controller: NewsViewController()),
        IconModel(iconName: "fourteen-huangli", title: "老黄历", controller: NewsViewController()),
        IconModel(iconName: "fifteen-wifi", title: "全国WIFI", controller: NewsViewController()),
        IconModel(iconName: "sixteen-data", title: "净值数据", controller: NewsViewController()),
        IconModel(iconName: "seventeen-jijin", title: "暂停基金", controller: NewsViewController()),
        IconModel(iconName: "eighteen-huangjin", title: "黄金数据", controller: NewsViewController()),
        IconModel(iconName: "nineteen-shenfen", title: "身份证查询", controller: NewsViewController()),
        IconModel(iconName: "twenty-book", title: "图书电商数据", controller: NewsViewController()),
        IconModel(iconName: "twenty-one-xingzuo", title: "星座运势", controller: NewsViewController()),
        IconModel(iconName: "twenty-two", title: "周公解梦", controller: NewsViewController()),
        IconModel(iconName: "twenty-three", title: "IP地址", controller: NewsViewController()),
        IconModel(iconName: "twenty-four", title: "H5在线电影票", controller: NewsViewController())
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "OpenData"
        self.view.backgroundColor = UIColor.white
        self.view.autoresizesSubviews = false
        
        let width = (UIScreen.main.bounds.width - 64) / 3
        let flow = UICollectionViewFlowLayout()
        flow.minimumLineSpacing = 16
        flow.itemSize = CGSize(width: width, height: width * 1.24)
        flow.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flow)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(IconCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        self.view.addSubview(collectionView)
        collectionView.snp_makeConstraints({make in
            make.left.top.right.bottom.equalToSuperview()
        })
        
    }
    
    @objc func injected(){
        print("I've been injected: \(self)")
        viewDidLoad()
    }

    @objc func tapCell(tap: UITapGestureRecognizer) {
        let cell = tap.view as! IconCell
        self.navigationController?.pushViewController((cell.iconModel?.controller!)!, animated: true)
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! IconCell
        cell.setIconModel(model: iconList[indexPath.row])
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapCell))
        cell.addGestureRecognizer(tap)
        return cell
    }
    
   
    
}

