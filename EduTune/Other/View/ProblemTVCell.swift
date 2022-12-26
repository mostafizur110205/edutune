//
//  ProblemTVCell.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 30/10/22.
//

import UIKit

class ProblemTVCell: UITableViewCell {

    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var invoiceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var errorTypeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        addShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func addShadow() {
        mainContentView.layer.masksToBounds = false
        mainContentView.layer.shadowColor = UIColor.init(hex: "535990", alpha: 0.2).cgColor
        mainContentView.layer.cornerRadius = 10.0
        mainContentView.layer.shadowOffset = CGSize(width: 0, height: 3)
        mainContentView.layer.shadowRadius = 5
        mainContentView.layer.shadowOpacity = 0.5
    }

    var problem: Problem? {
        didSet {
            invoiceLabel.text = "Ticket # \(problem?.id ?? 0)"
            dateLabel.text = getDateTime(problem?.created_at)
            detailsLabel.text = problem?.problem_description
        }
    }
    
    func getDateTime(_ dateTime: String?) -> (String?) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormater.date(from: dateTime ?? "") {
            return date.dateStringWithFormat(format: "H:mm a dd/M/yyyy")
        }else{
            return dateTime
        }
    }
    
}
