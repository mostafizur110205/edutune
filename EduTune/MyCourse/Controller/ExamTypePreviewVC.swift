//
//  ExamTypePreviewVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 6/12/22.
//

import UIKit

class ExamTypePreviewVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var timelLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var viewSubmissionButton: UIButton!

    var classData: DueAssignments?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.tabBarController?.tabBar.isHidden = true

        updateUI()
    }
    
    func updateUI() {
        previewImageView.sd_setImage(with: URL(string: classData?.subjectImage ?? "" ), placeholderImage: nil)
        categoryLabel.text = "  \(classData?.className ?? "")  "
        titleLabel.text = classData?.name
        nameLabel.text = classData?.name
        viewSubmissionButton.setTitle("View all submission (\(classData?.getSubmissionsCount ?? 0))", for: .normal)
        timelLabel.text = "Time: \(classData?.examTime ?? 0) min"
        
        let (date, isDuePassed) = AppDelegate.shared().getDueDate(classData?.dueDate)
        dateLabel.text = "Due: \(date.replacingOccurrences(of: "00:00 AM", with: "12:00 AM"))"
        dateLabel.textColor = UIColor(named: isDuePassed ? "Primary500" : "AlertError")
    }
    
    @IBAction func onViewSubmissionButtonTap(_ sender: Any) {
 // view submission
    }
  
    @IBAction func onStartAssignment(_ sender: Any) {
        
        let instructionsVC = InstructionsVC(viewModel:
                AssignmentsViewModel(apiService:
                    AssignmentApiService()))
        
        let bottomSheetViewModel = BottomSheetViewModel(
            cornerRadius: 20,
            animationTransitionDuration: 0.3,
            backgroundColor: UIColor.black.withAlphaComponent(0.5)
        )
        
        let bottomSheetVC = BottomSheetVC(
            viewModel: bottomSheetViewModel,
            childViewController: instructionsVC
        )
        instructionsVC.bottomSheetVC = bottomSheetVC
        instructionsVC.superView = self
        instructionsVC.assignment = classData

        presentBottomSheet(bottomSheetVC, completion: nil)
    }
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

public extension UIViewController {
    internal func presentBottomSheet(_ bottomSheet: BottomSheetVC, completion: (() -> Void)?) {
        self.present(bottomSheet, animated: false, completion: completion)
    }
}
