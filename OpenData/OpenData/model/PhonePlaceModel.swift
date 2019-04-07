//
//  PhonePlaceModel.swift
//  OpenData
//
//  Created by jiyou xu on 2019/4/7.
//  Copyright © 2019 jiyou xu. All rights reserved.
//

import Foundation

struct PhoneApiData: Codable {
    let resultcode: String
    let reason: String
    let result: PhonePlaceModel?
}

struct PhonePlaceModel: Codable {
    let province: String
    let city: String
    let areacode: String
    let zip: String
    let company: String
}
