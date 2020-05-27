//
//  ColorExtension.swift
//  TecNutricion-iOS
//
//  Created by user168638 on 5/24/20.
//  Copyright © 2020 FernandoCarrillo. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    static let theme = UIColor(netHex: 0x45B4BE)
    static let themeHighlighted = UIColor(netHex: 0x45B4C8)
    static let background = UIColor(netHex: 0xf4f4f4)
    static let darkFont = UIColor(netHex: 0x717171)
}
