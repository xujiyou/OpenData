//
//  LotteryTypeCell.swift
//  OpenData
//
//  Created by jiyou xu on 2019/4/8.
//  Copyright © 2019 jiyou xu. All rights reserved.
//

import UIKit

class LotteryTypeCell: UITableViewCell {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(label)
        return label
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = primaryColor
        self.addSubview(label)
        return label
    }()
    
    lazy var remarkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = primaryColor
        self.addSubview(label)
        return label
    }()
    
    lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1.0)
        self.addSubview(view)
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.nameLabel.snp_makeConstraints({make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(8)
        })
        
        self.typeLabel.snp_makeConstraints({make in
            make.left.equalToSuperview().offset(24)
            make.top.equalTo(self.nameLabel.snp_bottom).offset(12)
        })
        
        self.remarkLabel.snp_makeConstraints({make in
            make.left.equalToSuperview().offset(24)
            make.top.equalTo(self.typeLabel.snp_bottom).offset(6)
        })
        
        self.dividerView.snp_makeConstraints({make in
            make.top.equalTo(self.remarkLabel.snp_bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.4)
        })
    }
    
    func setModel(model: LotteryTypeModel) {
        self.nameLabel.text = model.lotteryName
        if model.lotteryTypeId == "1" {
            self.typeLabel.text = "· 福利彩票"
        } else {
            self.typeLabel.text = "· 体育彩票"
        }
        self.remarkLabel.text = "· " + model.remarks
    }

}
