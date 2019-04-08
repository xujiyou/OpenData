//
//  UIViewAdditions.swift
//  OpenData
//
//  Created by jiyou xu on 2019/4/6.
//  Copyright © 2019 jiyou xu. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func width() -> CGFloat {
        return self.frame.size.width
    }
    
    func height() -> CGFloat {
        return self.frame.size.height
    }
    
    func origin() -> CGPoint {
        return self.frame.origin
    }
}
