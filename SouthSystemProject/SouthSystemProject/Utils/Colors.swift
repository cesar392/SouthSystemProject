//
//  Colors.swift
//  SouthSystemProject
//
//  Created by Cesar Comelli on 31/07/22.
//

import Foundation
import UIKit

extension UIColor {
   static private func color(hexString: String) -> UIColor {
        let colorValues = hexString.uppercased().replacingOccurrences(of: "#", with: "").split(by: 2)
        if colorValues.count == 3 {
            let r = CGFloat(Int(colorValues[0], radix: 16)!)
            let g = CGFloat(Int(colorValues[1], radix: 16)!)
            let b = CGFloat(Int(colorValues[2], radix: 16)!)
            return UIColor(red:   r / 0xFF,
                           green: g / 0xFF,
                           blue:  b / 0xFF,
                           alpha: 1) // #FB8C00
        } else {
            return UIColor(hexString: hexString)
        }
    }

    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }

    static var colorPrimary: UIColor { return UIColor.color(hexString: "#D9A3AC") }
    static var colorPrimaryDark: UIColor { return UIColor.color(hexString: "#CF8C95") }

}

extension String {
    func split(by length: Int) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()

        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }

        return results.map { String($0) }
    }
}
