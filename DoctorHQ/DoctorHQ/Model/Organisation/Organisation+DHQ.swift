//
//  Organisation+DHQ.swift
//  DoctorHQ
//
//  Created by Glenn Posadas on 6/11/19.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Foundation

extension Organisation {
    /// The formatted title of the Org.
    var formattedTitle: String {
        get {
            return self.title ?? ""
        }
    }
    
    /// The formatted address of the Org.
    var formattedAddress: String {
        get {
            if let address = self.address {
                return address.joined(separator: " ")
            }
            
            return "No address available".localized()
        }
    }
    
    
}
