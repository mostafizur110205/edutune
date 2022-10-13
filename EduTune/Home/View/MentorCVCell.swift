//
//  MentorCVCell.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 13/10/22.
//

import UIKit

class MentorCVCell: UICollectionViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!

    var teacher: Teacher? {
        didSet {
            userImageView.sd_setImage(with: URL(string: teacher?.portfolio_photo ?? "" ), placeholderImage: nil)
            usernameLabel.text = teacher?.name
        }
    }
    
}
