//
//  CategoryCVCell.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 13/10/22.
//

import UIKit

class CategoryCVCell: UICollectionViewCell {
   
    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView?

    private var showBorderSelected: Bool = false

    func configure(with text: String?, selected: Bool, height: CGFloat) {
        self.borderWidth = 2
        self.cornerRadius = height/2
        self.tagNameLabel.text = text
        self.showBorderSelected = selected
        self.iconImageView?.image = UIImage(named: selected ? "ic_star_white" : "ic_star_blue")
        self.setupUI()
    }
    
    private func setupUI() {
        if self.showBorderSelected {
            self.tagNameLabel.textColor = .white
            self.borderColor = UIColor.clear
            self.backgroundColor = UIColor.init(hex: "335EF7", alpha: 1)
        } else {
            self.tagNameLabel.textColor = UIColor.init(hex: "335EF7", alpha: 1)
            self.borderColor = UIColor.init(hex: "335EF7", alpha: 1)
            self.backgroundColor = .clear
        }
    }
    
}
