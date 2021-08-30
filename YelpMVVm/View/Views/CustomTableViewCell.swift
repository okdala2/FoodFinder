//
//  CustomTableViewCell.swift
//  YelpMVVm
//
//  Created by Dala  on 8/27/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    static let identifier = "FoodCell"

    @IBOutlet weak var businessImageLabel: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var accessLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
}
