//
//  LotteryTypeModel.swift
//  OpenData
//
//  Created by jiyou xu on 2019/4/8.
//  Copyright © 2019 jiyou xu. All rights reserved.
//

import Foundation

struct LotteryTypeApiData: Codable {
    let reason: String
    let result: [LotteryTypeModel]
}


struct LotteryTypeModel: Codable {
    let lotteryId: String
    let lotteryName: String
    let lotteryTypeId: String
    let remarks: String
    
    enum CodingKeys: String, CodingKey {
        case lotteryId = "lottery_id"
        case lotteryName = "lottery_name"
        case lotteryTypeId = "lottery_type_id"
        case remarks
    }
}
