//
//  DueAssismentTVCell.swift
//  EduTune
//
//  Created by Machtonis on 11/13/22.
//
import UIKit

class DueAssignmentsTVCell: UITableViewCell {
    @IBOutlet weak var mainContentView: UIView!
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

        mainContentView.layer.masksToBounds = false
        mainContentView.layer.shadowColor = UIColor.init(hex: "535990", alpha: 0.2).cgColor
        mainContentView.layer.cornerRadius = 10.0
        mainContentView.layer.shadowOffset = CGSize(width: 0, height: 3)
        mainContentView.layer.shadowRadius = 5
        mainContentView.layer.shadowOpacity = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    var classData: DueAssignments? {
        didSet {
            cellImageView.sd_setImage(with: URL(string: classData?.subjectImage ?? "" ), placeholderImage: nil)
            categoryLabel.text = "  \(classData?.className ?? "")  "
            titleLabel.text = classData?.name
            priceLabel.text = "৳\(classData?.examTime ?? 0)"
            //statusLabel.text = classData?.mode == 1 ? "Batch" : "Recorded Class"
            
//            if classData?.original_price ?? 0 == 0 {
//                oldPriceLabel.text = ""
//                oldPriceLine.isHidden = true
//            } else {
//                oldPriceLabel.text = "৳\(classData?.original_price ?? 0)"
//                oldPriceLine.isHidden = false
//            }
//
//            let review = Float(classData?.get_user_review_avg_rating ?? "0") ?? 0
//
//            if review == 0 {
//                reviewStackView.isHidden = true
//            } else {
//                reviewStackView.isHidden = false
//                reviewLabel.text = String(format: "%.2f", review)
//            }

        }
    }

}
