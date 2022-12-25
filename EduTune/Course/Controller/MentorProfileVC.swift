//
//  MentorProfileVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 22/10/22.
//

import UIKit

class MentorProfileVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var designationLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    @IBOutlet weak var courseCountLabel: UILabel!
    @IBOutlet weak var studentCountLabel: UILabel!
    
    var teacher_id: Int?
    var teacher: Teacher? {
        didSet {
            updateUI()
        }
    }
    
    var allClasses = [Class]()
    
    var currentPage = 1
    var lastPage = 1
    var isAPICalling: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.isHidden = true
        getMentorDetails(page: currentPage)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func updateUI() {
        profileImageView.sd_setImage(with: URL(string: teacher?.portfolio_photo ?? "" ), placeholderImage: nil)
        nameLabel.text = teacher?.name
        designationLabel.text = teacher?.designation_name
        aboutLabel.text = teacher?.detail
        studentCountLabel.text = "\(teacher?.student_count ?? 0)"
        courseCountLabel.text = "\(teacher?.class_count ?? 0)"
        
        updateHeaderHeight()
    }
    
    func updateHeaderHeight() {
        if let headerView = tableView.tableHeaderView {
            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()
            
            let detailHeight = (teacher?.detail ?? "").heightOfLabel(font: UIFont.urbanist(style: .regular, ofSize: 14), width: (ScreenSize.SCREEN_WIDTH-32), numberOfLines: 0)
            
            var frame = headerView.frame
            frame.size.height = 330 + detailHeight // 390-60(message)
            headerView.frame = frame
            
            tableView.tableHeaderView = headerView
        }
        
        tableView.tableHeaderView?.layoutIfNeeded()
    }
    
    func getMentorDetails(page: Int) {
        if isAPICalling {
            return
        }
        let params = ["teacher_id": teacher_id ?? -1]
        
        APIService.shared.getMentorDetails(page: page, params: params) { teacher, classes, currentPage, lastPage in
            
            self.currentPage = currentPage
            self.lastPage = lastPage
            
            self.isAPICalling = false
            if page == 1 {
                self.teacher = teacher
                self.allClasses = classes
                self.tableView.isHidden = false
            } else {
                self.allClasses += classes
            }
            
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func onMessageButtonTap(_ sender: Any) {
        
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension MentorProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allClasses.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ClassTVCell") as? ClassTVCell else {return UITableViewCell()}
        
        let classData = allClasses[indexPath.row]
        cell.classData = classData
        
        if indexPath.row == allClasses.count-1 && currentPage < lastPage {
            getMentorDetails(page: currentPage + 1)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
