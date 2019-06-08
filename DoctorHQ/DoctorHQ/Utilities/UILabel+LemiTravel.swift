//
//  UILabel+DoctorHQ.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 28/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import UIKit

/// Category for UILabel helper functions
extension UILabel {
    /// A helper function for generating a new label and setting it up its normal properties.
    /// This means that the label has no special attributes.
    /// This uses the system font.
    static func new(
        withText text: String,
        fontSize: CGFloat,
        weight: UIFont.Weight = .regular,
        italic: Bool = false,
        textColor: UIColor = .darkGray,
        numberOfLines: Int = 1,
        textAlignment: NSTextAlignment = .natural) -> UILabel {
        let label = UILabel()
        label.font = italic ? UIFont.italicSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize, weight: weight)
        label.text = text
        label.textColor = textColor
        label.numberOfLines = numberOfLines
        label.textAlignment = textAlignment
        return label
    }
}
