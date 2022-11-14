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
    
    var classData: LiveClass? {
        didSet {
            cellImageView.sd_setImage(with: URL(string: classData?.image ?? "" ), placeholderImage: nil)
            categoryLabel.text = "  \(classData?.hostName ?? "")  "
            titleLabel.text = classData?.className
            priceLabel.text = "\(Extensions.getTimeFrom24Time(timeStr: classData?.startTime)) - \(Extensions.getTimeFrom24Time(timeStr: classData?.endTime))"
            reviewLabel.text = "Upcoming"
            statusLabel.text = "10 min remaining"
            oldPriceLabel.isHidden = true
            
            
            
        }
    }
    
}
