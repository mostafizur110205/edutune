//
//  ClassTVCell.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 13/10/22.
//

import UIKit

class ClassTVCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var oldPriceLine: UIView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var reviewStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    var classData: Class? {
        didSet {
            cellImageView.sd_setImage(with: URL(string: classData?.photo ?? "" ), placeholderImage: nil)
            categoryLabel.text = "  \(classData?.program_name ?? "")  "
            titleLabel.text = classData?.name
            priceLabel.text = "৳\(classData?.current_price ?? 0)"
            statusLabel.text = classData?.mode == 1 ? "Batch" : "Recorded Class"
            
            if classData?.original_price ?? 0 == 0 {
                oldPriceLabel.text = ""
                oldPriceLine.isHidden = true
            } else {
                oldPriceLabel.text = "৳\(classData?.original_price ?? 0)"
                oldPriceLine.isHidden = false
            }
            
            let review = Float(classData?.get_user_review_avg_rating ?? "0") ?? 0
            
            if review == 0 {
                reviewStackView.isHidden = true
            } else {
                reviewStackView.isHidden = false
                reviewLabel.text = String(format: "%.2f", review)
            }

        }
    }

}
