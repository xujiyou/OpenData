//
//  IconCell.swift
//  OpenData
//
//  Created by jiyou xu on 2019/4/5.
//  Copyright © 2019 jiyou xu. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class IconCell: UICollectionViewCell {
    
    var iconModel: IconModel?
    
    lazy var iconView: UIImageView = {return UIImageView()}()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor(displayP3Red: 88 / 255, green: 88 / 255, blue: 88 / 255, alpha: 1.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 0.4
        self.layer.cornerRadius = 4.0
        self.layer.borderColor = UIColor(displayP3Red: 200 / 255, green: 200 / 255, blue: 200 / 255, alpha: 1.0).cgColor
        
        let width = UIScreen.main.bounds.width / 10
        
        let contentView = UIView()
        contentView.backgroundColor = UIColor.blue
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        self.addSubview(contentView)
        
        contentView.snp_makeConstraints({make in
            make.center.equalToSuperview()
        })
        iconView.snp_makeConstraints({make in
            make.centerX.equalToSuperview()
            make.height.equalTo(width)
            make.width.equalTo(width * 1.2)
        })
        titleLabel.snp_makeConstraints({make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconView.snp_bottom).offset(16)
        })
        contentView.snp_makeConstraints({make in
            make.top.equalTo(iconView)
            make.bottom.equalTo(titleLabel)
            
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setIconModel(model: IconModel) {
        self.iconModel = model
        self.iconView.image = UIImage(named: model.iconName!)
        self.titleLabel.text = model.title!
    }
}

extension UIImage {
    /**
     *  重设图片大小
     */
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize, false, UIScreen.main.scale);
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.width))
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
}
