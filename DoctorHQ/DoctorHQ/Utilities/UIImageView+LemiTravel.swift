//
//  UIImageView+DoctorHQ.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 28/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import UIKit

/// Category for `UIImageView`.
extension UIImageView {
    /// Generates new `UIImageView`.
    class func new(withImageName imageName: String?, contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImageView {
        let image = UIImage(named: imageName ?? "")
        let imageView = UIImageView(image: image)
        imageView.contentMode = contentMode
        imageView.clipsToBounds = true
        return imageView
    }    
}
