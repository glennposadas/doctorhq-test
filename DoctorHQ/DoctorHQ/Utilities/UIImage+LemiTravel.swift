//
//  UIImage+DoctorHQ.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 28/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import UIKit

extension UIImage {
    /// Scale image.
    func scaleImage(toSize newSize: CGSize) -> UIImage? {
        var newImage: UIImage?
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        if let context = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage {
            context.interpolationQuality = .high
            let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)
            context.concatenate(flipVertical)
            context.draw(cgImage, in: newRect)
            if let img = context.makeImage() {
                newImage = UIImage(cgImage: img)
            }
            UIGraphicsEndImageContext()
        }
        return newImage
    }

}
