//
//  DetailViewController.swift
//  YelpMVVm
//
//  Created by Dala  on 8/27/21.
//

import UIKit


class DetailViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var website: UILabel!
    
    let name = String()
    let rating = String()
    let distance = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        nameLabel.text = "Name: \(name)"
        ratingLabel.text = "Rating: \(rating)"
        distanceLabel.text = "Distance: \(distance)"
    }
}
