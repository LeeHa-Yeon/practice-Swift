//
//  UIColor.swift
//  CustomPopUp
//
//  Created by hayeon.lee on 2022/08/09.
//

import UIKit

extension UIColor {
    // MARK: hex code를 이용하여 정의
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }

}
