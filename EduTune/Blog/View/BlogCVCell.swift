//
//  BlogCVCell.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 23/10/22.
//

import UIKit

class BlogCVCell: UICollectionViewCell {
    
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!

    var blog: Blog? {
        didSet {
            cellImageView.sd_setImage(with: URL(string: blog?.post_image ?? "" ), placeholderImage: nil)
            titleLabel.text = blog?.post_title
            subtitleLabel.text = blog?.post_short_content
            categoryLabel.text = "  \(blog?.type?.type_name ?? "")  "
           
            addShadow()
        }
    }
    
    func addShadow() {
        mainContentView.layer.masksToBounds = false
        mainContentView.layer.shadowColor = UIColor.init(hex: "535990", alpha: 0.2).cgColor
        mainContentView.layer.cornerRadius = 10.0
        mainContentView.layer.shadowOffset = CGSize(width: 0, height: 3)
        mainContentView.layer.shadowRadius = 5
        mainContentView.layer.shadowOpacity = 0.5
    }
    
}
