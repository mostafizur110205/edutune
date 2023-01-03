//
//  SubmissionTVCell.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 3/1/23.
//

import UIKit

protocol SubmissionTVCellDelegate {
    func didResumeButtonTap(_ cell: SubmissionTVCell)
    func didViewAnswerButtonTap(_ cell: SubmissionTVCell)
}

class SubmissionTVCell: UITableViewCell {

    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var marksLabel: UILabel?
    @IBOutlet weak var submissionStatusLabel: UILabel!
    @IBOutlet weak var submittedDateLabel: UILabel?
    @IBOutlet weak var viewSubmissionHeightCns: NSLayoutConstraint?
   
    var delegate: SubmissionTVCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        addShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    var submission: Submission? {
        didSet {
            startDateLabel.text = submission?.started
            marksLabel?.text = submission?.obtain_marks
            submissionStatusLabel.text = submission?.message
            submittedDateLabel?.text = submission?.submission_date
            viewSubmissionHeightCns?.constant = (submission?.view_details ?? "").isEmpty ? 0 : 50
        }
    }
    
    func addShadow() {
        mainContentView.layer.masksToBounds = false
        mainContentView.layer.shadowColor = UIColor.init(hex: "535990", alpha: 0.2).cgColor
        mainContentView.layer.cornerRadius = 10.0
        mainContentView.layer.shadowOffset = CGSize(width: 0, height: 3)
        mainContentView.layer.shadowRadius = 5
        mainContentView.layer.shadowOpacity = 0.5
    }

    @IBAction func onResumeButtonTap(_ sender: Any) {
        delegate?.didResumeButtonTap(self)
    }
    
    @IBAction func onViewAnswerButtonTap(_ sender: Any) {
        delegate?.didViewAnswerButtonTap(self)
    }

}
