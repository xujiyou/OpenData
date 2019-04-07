//
//  NewsCell.swift
//  OpenData
//
//  Created by jiyou xu on 2019/4/7.
//  Copyright © 2019 jiyou xu. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import AlamofireImage

class NewsCell: UITableViewCell {
    
    var newsModel: NewsModel?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.sizeToFit()
        self.addSubview(label)
        return label
    }()
    
    lazy var oneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4.0
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        self.addSubview(imageView)
        return imageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4.0
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        self.addSubview(imageView)
        return imageView
    }()
    
    lazy var threeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4.0
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        self.addSubview(imageView)
        return imageView
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        self.addSubview(label)
        return label
    }()
    
    lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
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
        self.titleLabel.snp_makeConstraints({make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-16)
        })
        let height = (UIScreen.main.bounds.size.width - 48) / 3 / 4 * 3
        self.oneImageView.snp_makeConstraints({make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(self.titleLabel.snp_bottom).offset(8)
            make.right.equalToSuperview().dividedBy(3)
            make.height.equalTo(height)
        })
        self.twoImageView.snp_makeConstraints({make in
            make.left.equalTo(self.oneImageView.snp_right).offset(8)
            make.top.equalTo(self.titleLabel.snp_bottom).offset(8)
            make.right.equalToSuperview().dividedBy(1.5).offset(-8)
            make.height.equalTo(height)
        })
        self.threeImageView.snp_makeConstraints({make in
            make.left.equalTo(self.twoImageView.snp_right).offset(8)
            make.top.equalTo(self.titleLabel.snp_bottom).offset(8)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(height)
        })
        self.authorLabel.snp_makeConstraints({make in
            make.top.equalTo(self.oneImageView.snp_bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            
        })
        self.dataLabel.snp_makeConstraints({make in
            make.top.equalTo(self.oneImageView.snp_bottom).offset(8)
            make.left.equalTo(self.authorLabel.snp_right).offset(12)
        })
        self.dividerView.snp_makeConstraints({make in
            make.top.equalTo(self.authorLabel.snp_bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.4)
        })
    }
    
    func setNewsModel(model: NewsModel) {
        self.newsModel = model
        self.titleLabel.text = model.title
        self.authorLabel.text = model.authorName
        self.dataLabel.text = model.date
        if model.threeThumbnail != nil {
            self.oneImageView.af_setImage(withURL: URL(string: model.oneThumbnail!)!)
            self.twoImageView.af_setImage(withURL: URL(string: model.twoThumbnail!)!)
            self.threeImageView.af_setImage(withURL: URL(string: model.threeThumbnail!)!)
        } else if model.twoThumbnail != nil {
            self.oneImageView.af_setImage(withURL: URL(string: model.oneThumbnail!)!)
            self.twoImageView.af_setImage(withURL: URL(string: model.twoThumbnail!)!)
        } else if model.oneThumbnail != nil {
            self.oneImageView.af_setImage(withURL: URL(string: model.oneThumbnail!)!)
        }
    }
}
