//
//  DHQDefaults.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 29/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Foundation

enum DHQDefaultsKey: String {
    case selectedCities = "defaultsSelectedCities"
}

/// The class that has multiple class functions for handling defaults.
class DHQDefaults {
    
    // MARK: - Functions
    
    /// Stores token.
    class func store<T>(_ object: T, key: DHQDefaultsKey, type: T.Type) {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: object)
        UserDefaults.standard.set(encodedData, forKey: key.rawValue)
    }
    
    /// Removes the stored token
    class func removeDefaultsWithKey(_ key: DHQDefaultsKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    /// Returns stored token (optional) if any.
    class func getObjectWithKey<T>(_ key: DHQDefaultsKey, type: T.Type) -> T? {
        guard let savedData = UserDefaults.standard.data(forKey: key.rawValue) else {
            return nil
        }
        
        guard let object = NSKeyedUnarchiver.unarchiveObject(with: savedData) as? T else { return nil }
        
        return object
    }
    
}
