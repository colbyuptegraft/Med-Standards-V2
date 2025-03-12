//
//  Int+Extension.swift
//  Med Standards
//
//  Created by Oleksandr on 10.02.2025.
//  Copyright © 2025 ColbyCoApps. All rights reserved.
//

import UIKit

extension Int {

    private var iPhoneXSize: (width: CGFloat, height: CGFloat) { (375, 812) }
    private var screenSize: CGSize { UIScreen.main.bounds.size }
    
    /// Make proportional to iPhoneX screen width only if current device width is greater than iPhoneX width.
    var fitWMore: CGFloat {
        let ratio = screenSize.width / iPhoneXSize.width
        return ratio > 1 ? CGFloat(self) * ratio : CGFloat(self)
    }
    
    /// Make it proportional to the ratio of the current device's screen width to the iPhoneX screen width.
    var fitW: CGFloat {
        let ratio = screenSize.width / iPhoneXSize.width
        return CGFloat(self) * ratio
    }
    
    /// Make it proportional to the ratio of the current device's screen height to the iPhoneX screen height.
    var fitH: CGFloat {
        let ratio = screenSize.height / iPhoneXSize.height
        return CGFloat(self) * ratio
    }
}
