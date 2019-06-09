//
//  Organisation.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 08/06/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Foundation

struct Organisation: Codable {
    
    let address : [String]?
    let distance : Int?
    let email : String?
    let estimatedWait : String?
    let id : String?
    let lat : String?
    let lon : String?
    let mapLink : MapLink?
    let openingTimesHelper : [OpeningTimesHelper]?
    let openingtimes : [String]?
    let price : String?
    let telephone : String?
    let title : String?
    let website : String?
    
    enum CodingKeys: String, CodingKey {
        case address = "address"
        case distance = "distance"
        case email = "email"
        case estimatedWait = "estimated_wait"
        case id = "id"
        case lat = "lat"
        case lon = "lon"
        case mapLink = "mapLink"
        case openingTimesHelper = "opening_times_helper"
        case openingtimes = "openingtimes"
        case price = "price"
        case telephone = "telephone"
        case title = "title"
        case website = "website"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decodeIfPresent([String].self, forKey: .address)
        distance = try values.decodeIfPresent(Int.self, forKey: .distance)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        estimatedWait = try values.decodeIfPresent(String.self, forKey: .estimatedWait)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        mapLink = try values.decodeIfPresent(MapLink.self, forKey: .mapLink)
        openingTimesHelper = try values.decodeIfPresent([OpeningTimesHelper].self, forKey: .openingTimesHelper)
        openingtimes = try values.decodeIfPresent([String].self, forKey: .openingtimes)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        telephone = try values.decodeIfPresent(String.self, forKey: .telephone)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        website = try values.decodeIfPresent(String.self, forKey: .website)
    }
    
}
