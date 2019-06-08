//
//  UITableViewCell+DoctorHQ.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 28/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import UIKit

/// Category for adding helper methods for setting up buttons
extension UIButton {
    /// Setups the button with attributed text.
    class func new(
        withIcon icon: UIImage?,
        title: String,
        normalFont: UIFont = UIFont.systemFont(ofSize: 16.0),
        normalTextColor: UIColor,
        highlightedFont: UIFont? = nil,
        highlightedTextColor: UIColor? = nil,
        backgroundColor: UIColor = .clear,
        horizontalAlignment: UIControl.ContentHorizontalAlignment = .center,
        isUnderlined: Bool = false,
        setGradientBG: Bool = false) -> UIButton {
        
        let button = UIButton(type: .custom)
        
        let normalAttrib = NSAttributedString(
            string: title,
            attributes: [
                .font : normalFont,
                .foregroundColor : normalTextColor,
                .underlineStyle : isUnderlined ? NSUnderlineStyle.single.rawValue : 0
            ]
        )
        
        let highlightedAttrib = NSAttributedString(
            string: title,
            attributes: [
                .font : highlightedFont ?? normalFont,
                .foregroundColor : highlightedTextColor ?? UIColor.lightGray,
                .underlineStyle : isUnderlined ? NSUnderlineStyle.single.rawValue : 0
            ]
        )
        
        button.setAttributedTitle(normalAttrib, for: .normal)
        button.setAttributedTitle(highlightedAttrib, for: .highlighted)
        button.contentHorizontalAlignment = horizontalAlignment
        button.contentVerticalAlignment = .center
        button.backgroundColor = backgroundColor
        button.setImage(icon, for: .normal)
        
        button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 8, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -3, bottom: 0, right: 0)
        
        return button
    }
    
}
