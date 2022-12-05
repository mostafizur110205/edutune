//
//  DueAssismentTVCell.swift
//  EduTune
//
//  Created by Machtonis on 11/13/22.
//
import UIKit

class OngoingTVCell: UITableViewCell {
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
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
    
    var classData: OngoingClass? {
        didSet {
            cellImageView.sd_setImage(with: URL(string: classData?.photo ?? "" ), placeholderImage: nil)
            titleLabel.text = classData?.name
            categoryLabel.text = "  \(classData?.mode == 1 ? "Batch" : "Course")  "
            let classCount = classData?.getClassContents.map({$0.get_lectures.count}).reduce(0, +)
            let viewCount = classData?.getClassContentView.map({$0.count ?? 0}).reduce(0, +)

            percentLabel.text = "\(viewCount ?? 0) / \(classCount ?? 0)"
            progressBar.progress = Float(viewCount ?? 0)/Float(classCount ?? 0)

        }
    }
    
}
