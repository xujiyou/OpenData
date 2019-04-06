//
//  IconModel.swift
//  OpenData
//
//  Created by jiyou xu on 2019/4/5.
//  Copyright © 2019 jiyou xu. All rights reserved.
//

import Foundation
import UIKit

class IconModel {
    var iconName: String?
    var title: String?
    var controller: UIViewController?
    
    init(iconName: String, title: String, controller: UIViewController) {
        self.iconName = iconName
        self.title = title
        self.controller = controller
    }
}
