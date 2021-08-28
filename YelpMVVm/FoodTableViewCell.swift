////
////  FoodTableViewCell.swift
////  YelpMVVm
////
////  Created by Dala  on 8/26/21.
////
//
//import UIKit
//
//class FoodTableViewCell: UITableViewCell {
//    static let identifier = "FoodCellTableViewCell"
//    
//    private let userImageView: UIImageView = {
//        var image = UIImageView()
//        image.clipsToBounds = true
//        image.contentMode = .scaleAspectFit
//        
//        return image
//    }()
//    
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .label
//        return label
//    }()
//    
//    private let usernameLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .secondaryLabel
//        return label
//    }()
//    
//    private let distanceLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .tertiaryLabel
//        return label
//    }()
//    
//    private let statusLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .green
//        return label
//    }()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.addSubview(userImageView)
//        contentView.addSubview(nameLabel)
//        contentView.addSubview(usernameLabel)
//        contentView.clipsToBounds = true
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        let imageWidth = contentView.frame.size.height - 10
//        userImageView.frame = CGRect(x: 5, y: 5, width: imageWidth, height: imageWidth)
//        
//        nameLabel.frame = CGRect(x: imageWidth + 10 ,  y: 0, width: contentView.frame.size.width-imageWidth, height: contentView.frame.size.height/2)
//        
//        usernameLabel.frame = CGRect(x: imageWidth + 10 , y: contentView.frame.size.height/2,  width: contentView.frame.size.width-imageWidth, height: contentView.frame.size.height/2)
//    }
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        
//    }
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        self.userImageView.layer.cornerRadius = 3.5
//        self.userImageView.clipsToBounds = true
//    }
//    
//}
