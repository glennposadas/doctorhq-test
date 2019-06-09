//
//  OpeningTimesHelper.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 08/06/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Foundation

struct OpeningTimesHelper: Codable {
    
    let close: String?
    let dow: Int?
    let open: String?
    
    enum CodingKeys: String, CodingKey {
        case close = "close"
        case dow = "dow"
        case open = "open"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        close = try values.decodeIfPresent(String.self, forKey: .close)
        dow = try values.decodeIfPresent(Int.self, forKey: .dow)
        open = try values.decodeIfPresent(String.self, forKey: .open)
    }
    
}
