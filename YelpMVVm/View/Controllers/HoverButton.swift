//
//  HoverButton.swift
//  YelpMVVm
//
//  Created by Dala  on 8/30/21.
//

import UIKit

//Hover Button on TableViewViewController
class HoverButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: CGRect.zero)
        self.backgroundColor = .blue
        self.setTitle(title, for: .normal)
    }
    
    func configure() {
        self.accessibilityIdentifier = "hoverButton"
        _ = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        self.layer.cornerRadius = 30
        self.backgroundColor = .systemRed
        let image = UIImage(systemName: "bubble.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        self.setImage(image, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.tintColor = .white
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.3
    }
}


