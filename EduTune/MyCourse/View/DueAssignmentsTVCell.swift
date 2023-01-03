//
//  DueAssismentTVCell.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 11/13/22.
//
import UIKit

class DueAssignmentsTVCell: UITableViewCell {
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!

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
            reviewLabel.text = "Submission (\(classData?.getSubmissionsCount ?? 0)) | Start Test"
            let (date, isDuePassed) = AppDelegate.shared().getDueDate(classData?.dueDate)
            priceLabel.text = "Due: \(date.replacingOccurrences(of: "00:00 AM", with: "12:00 AM"))"
            priceLabel.textColor = UIColor(named: isDuePassed ? "Primary500" : "AlertError")
        }
    }
    
    

}
