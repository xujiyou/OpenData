//
//  WebViewController.swift
//  OpenData
//
//  Created by jiyou xu on 2019/4/7.
//  Copyright © 2019 jiyou xu. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "新闻详情"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(webView)
        self.webView.snp_makeConstraints({make in
            make.edges.equalToSuperview()
        })
    }
    
    func setWebUrl(urlStr: String) {
        let webReq = URLRequest(url: URL(string: urlStr)!)
        self.webView.load(webReq)
    }

}
