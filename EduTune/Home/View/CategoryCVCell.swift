//
//  CategoryCVCell.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 13/10/22.
//

import UIKit

class CategoryCVCell: UICollectionViewCell {
   
    @IBOutlet weak var tagNameLabel: UILabel!

    private var showBorderSelected: Bool = false

    func configure(with text: String?, selected: Bool, height: CGFloat) {
        self.tagNameLabel.borderWidth = 1.4
        self.tagNameLabel.cornerRadius = height/2
        self.tagNameLabel.text = text
        self.showBorderSelected = selected
        self.setupUI()
    }
    
    private func setupUI() {
        if self.showBorderSelected {
            self.tagNameLabel.textColor = .white
            self.tagNameLabel.borderColor = UIColor.clear
            self.tagNameLabel.backgroundColor = UIColor.init(hex: "335EF7", alpha: 1)
        } else {
            self.tagNameLabel.textColor = UIColor.init(hex: "335EF7", alpha: 1)
            self.tagNameLabel.borderColor = UIColor.init(hex: "335EF7", alpha: 1)
            self.tagNameLabel.backgroundColor = .clear
        }
    }
    
}
