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
    @IBOutlet weak var mobileLabel: UILabel?
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
            mobileLabel?.text = "Mobile: \(problem?.mobile ?? "")"
            
            let (problemText, problemColor) = getProblemColor(problem?.problem_type ?? "")
            errorTypeLabel.text = "  \(problemText)  "
            errorTypeLabel.backgroundColor = UIColor.init(hex: problemColor, alpha: 1)
            
            let (statusText, statusColor) = getStatusColor(problem?.status ?? 0)
            statusLabel.text = "  \(statusText)  "
            statusLabel.backgroundColor = UIColor.init(hex: statusColor, alpha: 1)
            
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
    
    func getProblemColor(_ problem: String) -> (String, String) {
        switch problem {
        case "new_idea":
            return ("New Idea", "#03A9F4")
        case "error":
            return ("Error", "#f05050")
        case "suggestion":
            return ("Suggestion", "#78A943")
        default:
            return ("New Idea", "#03A9F4")
        }
    }
    
    func getStatusColor(_ status: Int) -> (String, String) {
        switch status {
        case 1:
            return ("New", "#78A943")
        case 2:
            return ("Processing", "#FF9800")
        case 3:
            return ("Resolved", "#9E9E9E")
        case 4:
            return ("No problem found", "#004e9e")
        default:
            return ("New", "#78A943")
        }
    }
    
}
