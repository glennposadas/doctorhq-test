//
//  CityHelper.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 29/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Foundation
import Kingfisher

extension City {
    /// The description used in the home cell.
    var homeCellDescription: String {
        get {
            return "You selected: \(self.name ?? "Unknown name")"
        }
    }
    
    /// Presentable name of the city.
    var namePresentable: String {
        get {
            return self.name ?? "Unknown name"
        }
    }
    
    /// Presentable country name of the city.
    var countryPresentable: String {
        get {
            return self.subtitle ?? "Uknown Country"
        }
    }
    
    /// Kingfisher's resource object for downloading avatar/banner of the city.
    /// Url is encoded.
    var bannerResource: Resource? {
        get {
            guard let url = self.banner?.URLEscaped else { return nil }
            return ImageResource(downloadURL: url, cacheKey: url.absoluteString)
        }
    }
    
    /// The image generated
    /// Ref: https://raw.githubusercontent.com/claudot/Swift-UIImageView-Letters/master/Classes/UIImageView%2BLetters.swift
    var avatarFromName: UIImage! {
        get {
            let scale = Float(UIScreen.main.scale)
            var size = CGSize(width: 40, height: 40)
            
            size.width = CGFloat(floorf((Float(size.width) * scale) / scale))
            size.height = CGFloat(floorf((Float(size.height) * scale) / scale))
            
            UIGraphicsBeginImageContextWithOptions(size, false, CGFloat(scale))
            let context = UIGraphicsGetCurrentContext()
            
            let bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
            let path = CGPath(ellipseIn: bounds, transform: nil)
            context?.addPath(path)
            context?.clip()
            
            // Fill
            context?.setFillColor(UIColor.random.cgColor)
            context?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
            
            // Text
            let text: String = "\(self.namePresentable.prefix(3))"
            
            let attributes: [NSAttributedString.Key : Any] = [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 15.0)
            ]
            
            let textSize = text.size(withAttributes: attributes)
            
            let rect = CGRect(x: bounds.size.width/2 - textSize.width/2, y: bounds.size.height/2 - textSize.height/2, width: textSize.width, height: textSize.height)
            
            text.draw(in: rect, withAttributes: attributes)
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return image
        }
    }
    
    /// UIColor generated from self, used for `avatarFromName`.
    var avatarBG: UIColor {
        get {
            guard let colorString = self.color else { return UIColor.random }
            let parsedColorString = colorString.replacingOccurrences(of: "#", with: "")
            
            if let colorInt = Int(parsedColorString, radix: 16) {
                return UIColor.colorWithRGBHex(colorInt)
            }
            
            return UIColor.random
        }
    }
}
