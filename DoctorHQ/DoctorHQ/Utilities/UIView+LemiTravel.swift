//
//  UIView+DoctorHQ.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 28/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import UIKit

/// A category for all views.
extension UIView {
    /// Helper for adding multiple subviews in a view.
    func addSubviews(_ views: UIView...) {
        views.forEach({self.addSubview($0)})
    }
    
    /// Used for copying a view. Returns Generic UIView
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
    
    /// Generates a generic view with specic bg.
    static func new(backgroundColor: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        return view
    }
}
