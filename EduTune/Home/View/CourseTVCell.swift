//
//  CourseTVCell.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 13/10/22.
//

import UIKit

class CourseTVCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    var classData: Class? {
        didSet {
            cellImageView.sd_setImage(with: URL(string: classData?.photo ?? "" ), placeholderImage: nil)
            categoryLabel.text = classData?.program_name
            titleLabel.text = classData?.name
            priceLabel.text = "৳\(classData?.current_price ?? 0)"
            oldPriceLabel.text = "৳\(classData?.original_price ?? 0)"
            reviewLabel.text = "\(classData?.get_user_review_avg_rating ?? "0")"
            statusLabel.text = classData?.mode == 1 ? "Batch" : "Recorded Class"
        }
    }

}
