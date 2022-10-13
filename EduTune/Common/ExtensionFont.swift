//
//  TRFont.swift
//  Commons
//
//  Created by Erick Rolando Avila Quiroz on 08/04/22.
//

import UIKit

public extension UIFont {

    enum TypeFont: String {
        case bold = "Bold"
        case regular = "Regular"
        case lightItalic = "LightItalic"
        case extraLightItalic = "ExtraLightItalic"
        case extraBoldItalic = "ExtraBoldItalic"
        case thin = "Thin"
        case mediumItalic = "MediumItalic"
        case semiBold = "SemiBold"
        case italic = "Italic"
        case black = "Black"
        case blackItalic = "BlackItalic"
        case light = "Light"
        case semiBoldItalic = "SemiBoldItalic"
        case boldItalic = "BoldItalic"
        case extraBold = "ExtraBold"
        case medium = "Medium"
        case extraLight = "ExtraLight"
        case thinItalic = "ThinItalic"
    }

    /// Font Work Sans Light
    ///
    /// - Parameter size: Font size you need
    /// - Returns: your custom font for custom size
    class func urbanist(style: TypeFont, ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Urbanist-\(style.rawValue)", size: size) ?? UIFont.systemFont(ofSize: size)
    }

}
