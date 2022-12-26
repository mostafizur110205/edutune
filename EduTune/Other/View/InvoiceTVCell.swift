//
//  InvoiceTVCell.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 26/12/22.
//

import UIKit

class InvoiceTVCell: UITableViewCell {

    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var invoiceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var refUdLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!

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
    
    var invoice: Invoice? {
        didSet {
            invoiceLabel.text = "Invoice id: \(invoice?.id ?? 0)"
            dateLabel.text = getDateTime(invoice?.created_at)
            refUdLabel.text = "\(invoice?.payment_mode ?? "")(\(invoice?.payment_ref ?? "-"))"
            amountLabel.text = invoice?.amount
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
