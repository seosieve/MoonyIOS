//
//  Colors.swift
//  Moony
//
//  Created by 서충원 on 7/13/24.
//

import UIKit

enum Colors {
    static let redContent = UIColor("#EF4962")
    
    static let blueContent = UIColor("#257F9A")
    static let blueDescription = UIColor("#2D9ABA")
    static let blueAccent = UIColor("#0FB2F8")
    
    static let blackBackground = UIColor("#0E0E0E")
    static let blackInterface = UIColor("#1E1E1E")
    static let blackContent = UIColor("#2C2C2C")
    static let blackDescription = UIColor("#707070")
    static let blackAccent = UIColor("#CFCFCF")
}

//MARK: - UIColor with Hex
extension UIColor {
    convenience init(_ hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a,r,g,b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a,r,g,b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a,r,g,b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a,r,g,b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
