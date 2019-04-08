//
//  LotteryViewController.swift
//  OpenData
//
//  Created by jiyou xu on 2019/4/8.
//  Copyright © 2019 jiyou xu. All rights reserved.
//

import UIKit

class LotteryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "彩票开奖结果"
        self.view.backgroundColor = UIColor.white
        
        let listButton = UIButton()
        listButton.setTitle("支持彩种列表", for: .normal)
        listButton.setTitleColor(primaryColor, for: .normal)
        listButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        listButton.layer.borderColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1.0).cgColor
        listButton.layer.cornerRadius = 4.0
        listButton.layer.borderWidth = 1.0
        listButton.addTarget(self, action: #selector(clickListButton), for: .touchUpInside)
        self.view.addSubview(listButton)
        
        listButton.snp_makeConstraints({make in
            make.left.equalToSuperview().offset(32)
            make.top.equalToSuperview().offset(60)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(42)
        })
        
        let resultButton = UIButton()
        resultButton.setTitle("开奖结果查询", for: .normal)
        resultButton.setTitleColor(primaryColor, for: .normal)
        resultButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        resultButton.layer.borderColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1.0).cgColor
        resultButton.layer.cornerRadius = 4.0
        resultButton.layer.borderWidth = 1.0
        self.view.addSubview(resultButton)
        
        resultButton.snp_makeConstraints({make in
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(listButton.snp_bottom).offset(12)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(42)
        })
        
        let historyButton = UIButton()
        historyButton.setTitle("历史开奖结果查询", for: .normal)
        historyButton.setTitleColor(primaryColor, for: .normal)
        historyButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        historyButton.layer.borderColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1.0).cgColor
        historyButton.layer.cornerRadius = 4.0
        historyButton.layer.borderWidth = 1.0
        self.view.addSubview(historyButton)
        
        historyButton.snp_makeConstraints({make in
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(resultButton.snp_bottom).offset(12)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(42)
        })
        
        let calcButton = UIButton()
        calcButton.setTitle("中奖计算器", for: .normal)
        calcButton.setTitleColor(primaryColor, for: .normal)
        calcButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        calcButton.layer.borderColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1.0).cgColor
        calcButton.layer.cornerRadius = 4.0
        calcButton.layer.borderWidth = 1.0
        self.view.addSubview(calcButton)
        
        calcButton.snp_makeConstraints({make in
            make.left.equalToSuperview().offset(32)
            make.top.equalTo(historyButton.snp_bottom).offset(12)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(42)
        })
    }
    
    @objc func injected(){
        print("I've been injected: \(self)")
        viewDidLoad()
    }
    
    @objc func clickListButton(button: UIButton) {
        self.navigationController?.pushViewController(LotteryListTableViewController(), animated: true)
    }

}
