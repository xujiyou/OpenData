//
//  NewsModel.swift
//  OpenData
//
//  Created by jiyou xu on 2019/4/7.
//  Copyright © 2019 jiyou xu. All rights reserved.
//

import Foundation

struct NewsApiData: Codable {
    let errorCode: Int
    let reason: String
    let result: NewsResult
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case reason
        case result
    }
}

struct NewsResult: Codable {
    let stat: String
    let data: [NewsModel]
}

struct NewsModel: Codable {
    let uniquekey: String
    let title: String
    let date: String
    let category: String
    let authorName: String
    let url: String
    let oneThumbnail: String?
    let twoThumbnail: String?
    let threeThumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case uniquekey
        case title
        case date
        case category
        case authorName = "author_name"
        case url
        case oneThumbnail = "thumbnail_pic_s"
        case twoThumbnail = "thumbnail_pic_s02"
        case threeThumbnail = "thumbnail_pic_s03"
    }
}
