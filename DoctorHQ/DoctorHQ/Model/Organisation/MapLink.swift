//
//  MapLink.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 08/06/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Foundation

struct MapLink: Codable {
    
    let android: String?
    let ios: String?
    let windows: String?
    
    enum CodingKeys: String, CodingKey {
        case android = "android"
        case ios = "ios"
        case windows = "windows"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        android = try values.decodeIfPresent(String.self, forKey: .android)
        ios = try values.decodeIfPresent(String.self, forKey: .ios)
        windows = try values.decodeIfPresent(String.self, forKey: .windows)
    }
    
}
