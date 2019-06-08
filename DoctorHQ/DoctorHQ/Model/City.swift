//
//  City.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 28/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Foundation

struct City: Codable, Hashable, Equatable {
    
    let banner : String?
    let color : String?
    let countryCode : String?
    let id : String?
    let latitude : Float?
    let longitude : Float?
    let name : String?
    let population : Int?
    let subtitle : String?
    let type : String?
    let zoom : Int?
    
    enum CodingKeys: String, CodingKey {
        case banner = "banner"
        case color = "color"
        case countryCode = "country_code"
        case id = "id"
        case latitude = "latitude"
        case longitude = "longitude"
        case name = "name"
        case population = "population"
        case subtitle = "subtitle"
        case type = "type"
        case zoom = "zoom"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        banner = try values.decodeIfPresent(String.self, forKey: .banner)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        latitude = try values.decodeIfPresent(Float.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Float.self, forKey: .longitude)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        population = try values.decodeIfPresent(Int.self, forKey: .population)
        subtitle = try values.decodeIfPresent(String.self, forKey: .subtitle)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        zoom = try values.decodeIfPresent(Int.self, forKey: .zoom)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id ?? "")
    }
}
