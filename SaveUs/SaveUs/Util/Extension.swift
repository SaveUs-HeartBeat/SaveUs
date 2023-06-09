//
//  Extension.swift
//  SaveUs
//
//  Created by Ruyha on 2023/05/27.
//

import UIKit
import MediaPlayer


extension UIColor {
    
    ///Hex값으로 컬러 할당 가능
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}

extension UIView {
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
}

extension CACornerMask {
    static var topLeft: CACornerMask { .layerMinXMinYCorner }
    static var topRight: CACornerMask { .layerMaxXMinYCorner }
    static var bottomLeft: CACornerMask { .layerMinXMaxYCorner }
    static var bottomRight: CACornerMask { .layerMaxXMaxYCorner }
}

extension UILabel {
    func setLineSpacing(spacing: CGFloat) {
        guard let text = text else { return }

        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        style.lineBreakStrategy = .hangulWordPriority
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
    
    
}
extension MPVolumeView {
     func setVolume(_ volume: Float) {
        
        let volumeView = MPVolumeView()
        let volumeSlider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            volumeSlider?.value = volume
        }
        
    }
}
