//
//  ViewController.swift
//  OpenData
//
//  Created by jiyou xu on 2019/4/4.
//  Copyright © 2019 jiyou xu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "OpenData"
        self.view.backgroundColor = UIColor.white
    }
    
    @objc func injected(){
        print("I've been injected: \(self)")
        viewDidLoad()
    }


}

