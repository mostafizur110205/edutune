//
//  BannerCVCell.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 13/10/22.
//

import UIKit
import SDWebImage

class BannerCVCell: UICollectionViewCell {

    @IBOutlet weak var cellImageView: UIImageView!

    var advertisement: Advertisement? {
        didSet {
            cellImageView.sd_setImage(with: URL(string: advertisement?.image ?? "" ), placeholderImage: nil)
        }
    }
}
