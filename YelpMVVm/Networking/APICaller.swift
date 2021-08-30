//
//  APICaller.swift
//  YelpMVVm
//
//  Created by Dala  on 8/26/21.
//

import UIKit

struct APICaller {
        
    static let shared = APICaller()

    let apiKey = "yE68wDZPFVU42ucJRxjusT38C__NyvDIwWkTOo1oxMHOpHzngZF0E9Pg-XMTa34HBOblDG22LYh2GxBh3_5awYiUYqBf_zw02CXD0nfBZvo-6iH0G7pHOmnmURkoYXYx"

    func fetchYelpBusinesses(latitude: Double, longitude: Double, completion: @escaping (Result<[Businesses], MyError>) -> Void) {
        let apikey = apiKey
        let url = URL(string: "https://api.yelp.com/v3/businesses/search?latitude=\(latitude)&longitude=\(longitude)")
        var request = URLRequest(url: url!)
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error  in
            guard let jsonData = data else { return }
            
            if let err = error {
                completion(.failure(MyError.invalidCall))
                print(err.localizedDescription)
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                print(json)

                let decoder = JSONDecoder()
                let resturantResponse = try decoder.decode(FoodRoot.self, from: jsonData)
                let resturantDetails = resturantResponse.businesses
                
                completion(.success(resturantDetails))
                                
                print("RESPONSE", resturantResponse ,"RESPONSE")
                
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
}

enum MyError: Error {
    case invalidCall
    case invalidData
}
