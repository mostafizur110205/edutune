//
//  MyCertificateCVCell.swift
//  Trendit
//
//  Created by Mostafizur Rahman on 9/11/22.
//

import UIKit

class MyCertificateCVCell: UICollectionViewCell {
    
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var lockImageView: UIImageView!
    @IBOutlet weak var lockView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var certificate: Certificate? {
        didSet {
            
            titleLabel.text = certificate?.class_name
            if let image = certificate?.certificate_image {
                cellImageView.sd_setImage(with: URL(string: image), placeholderImage: nil)
            } else {
                cellImageView.sd_setImage(with: URL(string: certificate?.certificate_default_image ?? "" ), placeholderImage: nil)
            }
            
            lockImageView.isHidden = (certificate?.certificate_status ?? 0) == 1
            lockView.isHidden = (certificate?.certificate_status ?? 0) == 1

        }
    }
    
    
}
