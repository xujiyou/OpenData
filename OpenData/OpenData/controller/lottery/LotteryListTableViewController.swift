//
//  LotteryListTableViewController.swift
//  OpenData
//
//  Created by jiyou xu on 2019/4/8.
//  Copyright © 2019 jiyou xu. All rights reserved.
//

import UIKit
import Alamofire

class LotteryListTableViewController: UITableViewController {
    
    var lotteryTypeModels: [LotteryTypeModel] = []
    
    let reuseIdentifier = "LotteryTypeCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "支持彩种列表"
        self.view.backgroundColor = UIColor.white
        
        self.tableView.separatorStyle = .none
        self.tableView.register(LotteryTypeCell.self, forCellReuseIdentifier: reuseIdentifier)
        self.tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        
        self.requestData()
    }
    
    func requestData() {
        Alamofire.request("http://apis.juhe.cn/lottery/types?key=69bfe37d8839f6f806a463eb362afa32").responseJSON(completionHandler: {response in
            if let jsonData = response.result.value {
                do {
                    let data = try JSONSerialization.data(withJSONObject: jsonData, options: [])
                    let apiData = try JSONDecoder().decode(LotteryTypeApiData.self, from: data)
                    self.lotteryTypeModels = apiData.result
                    self.tableView.reloadData()
                } catch {
                    print("出错了")
                }
            }
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lotteryTypeModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LotteryTypeCell
        cell.setModel(model: lotteryTypeModels[indexPath.row])
        return cell
    }

}
