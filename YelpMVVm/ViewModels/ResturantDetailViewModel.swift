//
//  ResturantDetailViewModel.swift
//  YelpMVVm
//
//  Created by Dala  on 8/29/21.
//

import UIKit

class ResturantDetailViewModel {

    var business: Businesses!

    var name: String!
    var distance: Double!
    var rating: Double!
    var address: String!
    var phone: String!
    var phoneDisplay: String!
    var access: Bool!
    var location: Location!
    
    var addressText: String!
    var ratingText: String!
    var distanceText: String!
    var nameText: String!
    var phoneText: String!
    var accessText: String!
    
    init(business: Businesses) {
        self.business = business
        self.name = business.name
        self.distance = business.distance
        self.rating = business.rating
        self.address = business.location?.address1
        self.phone = business.phone
        self.phoneDisplay = business.display_phone
        self.location = business.location
        
        nameText = name ?? "N//A"
        distanceText = "Distance: \(String(distance))"
        ratingText = "Rating: \(String(rating))"
        addressText = "Address: \(String(describing: address))"
        phoneText = "Phone: \(String(phone))"
        accessText = access ? "Is Closed" : "Is Open"
    }
}
