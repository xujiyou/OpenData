//
//  NewsTableViewController.swift
//  OpenData
//
//  Created by jiyou xu on 2019/4/7.
//  Copyright © 2019 jiyou xu. All rights reserved.
//

import UIKit
import Alamofire

class NewsTableViewController: UITableViewController {
    
    var type: String?
    
    var navController: UINavigationController?
    
    let identifier = "NewsCell"
    
    var newsModels: [NewsModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.tableView.register(NewsCell.self, forCellReuseIdentifier: identifier)
        self.tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        requestData()
    }
    
    func requestData() {
        Alamofire.request("http://v.juhe.cn/toutiao/index?type=\(type!)&key=e5c944d13ffcb73dc39aed78e528ddf3").responseJSON { response in
            if let jsonData = response.result.value {
                let data = try? JSONSerialization.data(withJSONObject: jsonData, options: [])
                let newsApiData = try! JSONDecoder().decode(NewsApiData.self, from: data!)
                self.newsModels = newsApiData.result.data
                self.tableView.reloadData()
            } else {
                NSLog("接收数据失败")
            }
        }
    }
    
    @objc func tapCell(tap: UITapGestureRecognizer) {
        let cell = tap.view as! NewsCell
        let webController = WebViewController()
        webController.setWebUrl(urlStr: (cell.newsModel?.url)!)
        navController?.pushViewController(webController, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! NewsCell
        cell.selectionStyle = .none
        cell.setNewsModel(model: newsModels[indexPath.row])
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapCell))
        cell.addGestureRecognizer(tap)
        return cell
    }

}
