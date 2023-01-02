//
//  DueFeesTVCell.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 26/12/22.
//

import UIKit

class DueFeesTVCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    var head: FeesHeads? {
        didSet {
            titleLabel.text = "Tution fee: \(head?.name ?? "")"
            amountLabel.text = head?.total_due_amount
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
