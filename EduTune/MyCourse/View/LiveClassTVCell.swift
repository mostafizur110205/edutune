//
//  DueAssismentTVCell.swift
//  EduTune
//
//  Created by Machtonis on 11/13/22.
//
import UIKit

class LiveClassTVCell: UITableViewCell {
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var lockLiveButton: UIButton!

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
    
    var classData: LiveClass? {
        didSet {
            cellImageView.sd_setImage(with: URL(string: classData?.image ?? "" ), placeholderImage: nil)
            categoryLabel.text = "  By \(classData?.teacherFullStr ?? "")  "
            titleLabel.text = classData?.className
            priceLabel.text = "\(Extensions.getTimeFrom24Time(timeStr: classData?.startTime)) - \(Extensions.getTimeFrom24Time(timeStr: classData?.endTime))"
          
            if classData?.status == .live {
                reviewLabel.text = "Click here to join"
                lockLiveButton.setImage(UIImage(named: "ic_video"), for: .normal)
            } else {
                let date = Date(timeIntervalSince1970: TimeInterval(classData?.startDateTime ?? 0))
                let formatter = DateComponentsFormatter()
                formatter.unitsStyle = .full
                formatter.maximumUnitCount = 1                  // or use 2 if you want
                formatter.includesTimeRemainingPhrase = true
                reviewLabel.text = "Upcoming  |  \(formatter.string(from: Date(), to: date) ?? "")"
                lockLiveButton.setImage(UIImage(named: "ic_lock_outlined"), for: .normal)
            }
            
        }
    }
    
}
