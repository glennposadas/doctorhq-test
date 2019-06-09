//
//  ConstraintMaker+DoctorHQ.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 28/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import SnapKit
import UIKit

/// Category for SnapKit's ConstraintMaker.
extension ConstraintMaker {
    /**
     Constraints the view to the superView's *top*
     Handles the safe area layout guide for iOS 11.0
     
     Example:
     - The following will properly set the inset for both iOS 10, 11, and 12.0 properly.
     - The reference inset 76.0 came from the top most view's top and the bottom of the statusBar.
     ```_ = $0.constraintToTop(self.view, inset: 76.0, navBarIsTransparent: true)```
     */
    public func constraintToTop(_ superview: UIView, inset amount: CGFloat = 0, navBarIsTransparent: Bool = false, navBarIsHidden: Bool = false) -> Constraint {
        if #available(iOS 11.0, *) {
            let offsetAmount = navBarIsTransparent ? (amount - 64.0) : amount
            return self.top.equalTo(superview.safeAreaLayoutGuide.snp.topMargin).offset(offsetAmount).constraint
        } else {
            let insetAmount = navBarIsHidden ? (amount + 20.0) : amount
            return self.top.equalToSuperview().inset(insetAmount).constraint
        }
    }
    
    /**
     Constraints the view to the superView's *bottom*
     Handles the safe area layout guide for iOS 11.0
     */
    public func constraintToBottom(_ superview: UIView, inset amount: CGFloat = 0) -> Constraint {
        if #available(iOS 11.0, *) {
            return self.bottom.equalTo(superview.safeAreaLayoutGuide.snp.bottomMargin).offset(amount * -1.0).constraint
        } else {
            return self.bottom.equalToSuperview().inset(amount).constraint
        }
    }
}


