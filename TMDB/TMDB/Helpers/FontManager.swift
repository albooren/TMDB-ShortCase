//
//  FontManager.swift
//  TMDB
//
//  Created by Alperen Kişi on 19.06.2022.
//

import Foundation
import UIKit

public enum FontName: String {
    case regular = "SanFranciscoText-Regular"
    case bold = "SanFranciscoText-Bold"
    case medium = "SanFranciscoText-Medium"
}

final class FontManager {
    
    static func fontRegular(_ size:CGFloat) -> UIFont {
        return UIFont.init(name: FontName.regular.rawValue, size: size)!
    }
    static func fontBold(_ size:CGFloat)->UIFont {
        return UIFont.init(name: FontName.bold.rawValue, size: size)!
    }
    static func fontMedium(_ size:CGFloat)->UIFont {
        return UIFont.init(name: FontName.medium.rawValue, size: size)!
    }
    
    static func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names = [\(names)]")
        }
    }
}
