//
//  UILabel + Extension.swift
//  Moony
//
//  Created by 서충원 on 7/14/24.
//

import UIKit

extension UILabel {
    /// Multiple Colored Attributed Label
    func withMultipleColor(_ color: UIColor, range: String) {
        let attributedString = NSMutableAttributedString(string: self.text!)
        attributedString.addAttribute(.foregroundColor, value: color, range: (self.text! as NSString).range(of: range))
        self.attributedText = attributedString
    }
    /// Custom Line Spaced Attributed Label
    func withLineSpacing(_ lineSpacing: CGFloat) {
        let attString = NSMutableAttributedString(string: self.text!)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpacing
        attString.addAttribute(.paragraphStyle, value: style, range: NSMakeRange(0, attString.length))
        self.attributedText = attString
    }
}
