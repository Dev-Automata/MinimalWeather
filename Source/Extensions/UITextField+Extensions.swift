//
//  UITextField+Extensions.swift
//  MinimalWeather
//
//  Created by Кирилл Михайлин on 18.11.2021.
//

import Foundation
import UIKit

extension UITextField {
    func addBottomBorder(tag: String, color: UIColor?) {
        let bottomLine = CALayer()

        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width - 20, height: 1)
        bottomLine.backgroundColor = color?.cgColor
        bottomLine.name = tag
        borderStyle = .none

        layer.addSublayer(bottomLine)
    }
    
    func changeBottomBorder(for tag: String, to color: UIColor?) {
        layer.sublayers?
            .filter { $0.name == tag }
            .forEach { $0.backgroundColor = color?.cgColor }
    }
}
