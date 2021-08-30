//
//  Models.swift
//  YelpMVVm
//
//  Created by Dala  on 8/26/21.
//

import Foundation
import CoreLocation

struct FoodRoot: Codable {
    let businesses: [Businesses]
}

struct Businesses: Codable {
    let id: String
    let name: String
    let distance: Double
    let rating: Double
    let is_closed: Bool?
    let display_phone: String
    let phone: String
    let image_url: String
    let categories: [Category]
    let coordinates: Coordinates?
    let location: Location?
    let review_count: Int
}

struct Category: Codable {
    var alias: String
    var title: String
}

struct Coordinates: Codable {
    var latitude: Double
    var longitude: Double
}

struct Location: Codable {
    var address1, address2, address3, city: String?
    var zipCode, country, state: String?
    var displayAddress: [String]?
    var crossStreets: String?

    enum CodingKeys: String, CodingKey {
        case address1, address2, address3, city
        case zipCode = "zip_code"
        case country, state
        case displayAddress = "display_address"
        case crossStreets = "cross_streets"
    }
    
    var appleMapsAddressString: String {
        let line1 = address1?.replacingOccurrences(of: " ", with: ",")
        let z = zipCode ?? ""
        return line1! + "," + z
    }
}
