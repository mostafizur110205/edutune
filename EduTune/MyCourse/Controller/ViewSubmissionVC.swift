//
//  ViewSubmissionVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 3/1/23.
//

import UIKit

class ViewSubmissionVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var submissions = [Submission]()
    var classData: DueAssignments?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getSubmissions()
        
    }
    
    func getSubmissions() {
        let params: [String : Any] = ["assignment_id": classData?.id ?? -1, "user_id": AppUserDefault.getUserId()]
        APIService.shared.getMyAssignmentSubmission(params: params) { submissions in
            self.submissions = submissions
            self.tableView.reloadData()
        }
    }

    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ViewSubmissionVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return submissions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let submission = submissions[indexPath.row]
        let cellId = submission.status == 1 ? "SubmissionTVCellR" : "SubmissionTVCell"

        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as? SubmissionTVCell else {return UITableViewCell()}
        
        cell.submission = submission
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension ViewSubmissionVC: SubmissionTVCellDelegate {
    func didResumeButtonTap(_ cell: SubmissionTVCell) {
        
    }
    
    func didViewAnswerButtonTap(_ cell: SubmissionTVCell) {
        
    }
    
    
}
