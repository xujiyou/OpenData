//
//  PhonePlaceViewController.swift
//  OpenData
//
//  Created by jiyou xu on 2019/4/7.
//  Copyright © 2019 jiyou xu. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class PhonePlaceViewController: UIViewController {
    
    var phonePlaceModel: PhonePlaceModel?
    
    lazy var phoneInput: UITextField = {
        let field = UITextField()
        field.placeholder = "请输入手机号"
        field.keyboardType = .phonePad
        field.borderStyle = .roundedRect
        field.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 30, height: 38))
        field.leftViewMode = .always
        let imgUser = UIImageView(frame:CGRect(x: 8, y: 8, width: 22, height: 22))
        imgUser.image = UIImage(named:"gender-neutral-user")
        field.leftView!.addSubview(imgUser)
        
        self.view.addSubview(field)
        return field
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.layer.borderColor = UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: 1.0).cgColor
        button.layer.borderWidth = 0.6
        button.setTitle("查询", for: .normal)
        button.setTitle("查询", for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(primaryColor, for: .normal)
        button.setTitleColor(UIColor.gray, for: .selected)
        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        
        self.view.addSubview(button)
        return button
    }()
    
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = primaryColor
        self.view.addSubview(label)
        return label
    }()
    
    lazy var provinceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = primaryColor
        self.view.addSubview(label)
        return label
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = primaryColor
        self.view.addSubview(label)
        return label
    }()
    
    lazy var zipLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = primaryColor
        self.view.addSubview(label)
        return label
    }()
    
    lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = primaryColor
        self.view.addSubview(label)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "手机号归属地查询"
        self.view.backgroundColor = UIColor.white
        
        self.phoneInput.snp_makeConstraints({make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(42)
            make.right.equalTo(self.searchButton.snp_left).offset(-12)
            make.height.equalTo(38)
        })
        
        self.searchButton.snp_makeConstraints({make in
            make.top.equalToSuperview().offset(42)
            make.right.equalToSuperview().offset(-16)
            make.width.equalTo(72)
            make.height.equalTo(38)
        })
        
        let phoneHintLabel = UILabel()
        phoneHintLabel.font = UIFont.systemFont(ofSize: 14)
        phoneHintLabel.text = "手机号："
        self.view.addSubview(phoneHintLabel)
        phoneHintLabel.snp_makeConstraints({make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(self.phoneInput.snp_bottom).offset(60)
        })
        
        self.phoneLabel.snp_makeConstraints({make in
            make.left.equalTo(phoneHintLabel.snp_right).offset(8)
            make.top.equalTo(phoneHintLabel)
        })
        
        let provinceHintLabel = UILabel()
        provinceHintLabel.font = UIFont.systemFont(ofSize: 14)
        provinceHintLabel.text = "省份："
        self.view.addSubview(provinceHintLabel)
        provinceHintLabel.snp_makeConstraints({make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(phoneHintLabel.snp_bottom).offset(12)
        })
        
        self.provinceLabel.snp_makeConstraints({make in
            make.left.equalTo(provinceHintLabel.snp_right).offset(8)
            make.top.equalTo(provinceHintLabel)
        })
        
        let cityHintLabel = UILabel()
        cityHintLabel.font = UIFont.systemFont(ofSize: 14)
        cityHintLabel.text = "城市："
        self.view.addSubview(cityHintLabel)
        cityHintLabel.snp_makeConstraints({make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(provinceHintLabel.snp_bottom).offset(12)
        })
        
        self.cityLabel.snp_makeConstraints({make in
            make.left.equalTo(cityHintLabel.snp_right).offset(8)
            make.top.equalTo(cityHintLabel)
        })
        
        let zipHintLabel = UILabel()
        zipHintLabel.font = UIFont.systemFont(ofSize: 14)
        zipHintLabel.text = "邮编："
        self.view.addSubview(zipHintLabel)
        zipHintLabel.snp_makeConstraints({make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(cityHintLabel.snp_bottom).offset(12)
        })
        
        self.zipLabel.snp_makeConstraints({make in
            make.left.equalTo(zipHintLabel.snp_right).offset(8)
            make.top.equalTo(zipHintLabel)
        })
        
        let companyHintLabel = UILabel()
        companyHintLabel.font = UIFont.systemFont(ofSize: 14)
        companyHintLabel.text = "运营商："
        self.view.addSubview(companyHintLabel)
        companyHintLabel.snp_makeConstraints({make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(zipHintLabel.snp_bottom).offset(12)
        })
        
        self.companyLabel.snp_makeConstraints({make in
            make.left.equalTo(companyHintLabel.snp_right).offset(8)
            make.top.equalTo(companyHintLabel)
        })
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapView))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func tapView(obj: Any) {
        self.phoneInput.resignFirstResponder()
    }
    
    @objc func clickButton(button: UIButton) {
        self.phoneInput.resignFirstResponder()
        if let phone = self.phoneInput.text {
            self.phoneLabel.text = phone
            self.phoneInput.text = ""
            Alamofire.request("http://apis.juhe.cn/mobile/get?phone=\(phone)&key=fc7546fc39d72008cce057f270f36136").responseJSON { response in
                if let jsonData = response.result.value {
                    let data = try? JSONSerialization.data(withJSONObject: jsonData, options: [])
                    do {
                        let phoneApiData = try JSONDecoder().decode(PhoneApiData.self, from: data!)
                        if let model = phoneApiData.result {
                            self.phonePlaceModel = model
                            self.provinceLabel.text = model.province
                            self.cityLabel.text = model.city
                            self.zipLabel.text = model.zip
                            self.companyLabel.text = model.company
                        } else {
                            self.alertPhoneError()
                        }
                    } catch let err as Error {
                        print(err)
                    }
                } else {
                    NSLog("接收数据失败")
                }
            }
        }
        
    }
    
    func alertPhoneError() {
        let alert = UIAlertController(title: "查不到手机号", message: "请检查手机号是否正确", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { action in})
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

}
