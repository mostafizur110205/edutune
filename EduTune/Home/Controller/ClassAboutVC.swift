//
//  ClassAboutVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 22/10/22.
//

import UIKit
import SJSegmentedScrollView

class ClassAboutVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var classDetail: ClassDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
}

extension ClassAboutVC: SJSegmentedViewControllerViewSource {
    
    func viewForSegmentControllerToObserveContentOffsetChange() -> UIView {
        return tableView
    }
}

extension ClassAboutVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (classDetail?.teachers.count ?? 0)+(classDetail?.required_resourses.count ?? 0)+3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row <= classDetail?.teachers.count ?? 0 {
            return classDetail?.teachers.count ?? 0 == 0 ? 0 : UITableView.automaticDimension
        } else if indexPath.row == (classDetail?.teachers.count ?? 0)+1 {
            return classDetail?.about ?? "" == "" ? 0 : UITableView.automaticDimension
        } else if indexPath.row == (classDetail?.teachers.count ?? 0)+2 {
            return classDetail?.certificate_image ?? "" == "" ? 0 : UITableView.automaticDimension
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ClassHeaderTVCell") as? ClassHeaderTVCell else {return UITableViewCell()}
            cell.titleLabel.text = "Mentor"
            return cell
        } else if indexPath.row <= classDetail?.teachers.count ?? 0 {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "MentorTVCell") as? MentorTVCell else {return UITableViewCell()}
            let teacher = classDetail?.teachers[indexPath.row-1]
            cell.teacher = teacher
            return cell
        } else if indexPath.row == (classDetail?.teachers.count ?? 0)+1 {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ClassAboutTVCell") as? ClassAboutTVCell else {return UITableViewCell()}
            cell.aboutLabel.attributedText = classDetail?.about?.htmlToAttributedString
            return cell
        } else if indexPath.row == (classDetail?.teachers.count ?? 0)+2 {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ClassCertificateTVCell") as? ClassCertificateTVCell else {return UITableViewCell()}
            cell.certificateImageView.sd_setImage(with: URL(string: classDetail?.certificate_image ?? "" ), placeholderImage: nil)
            return cell
        } else if indexPath.row == (classDetail?.teachers.count ?? 0)+3 {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ClassHeaderTVCell") as? ClassHeaderTVCell else {return UITableViewCell()}
            cell.titleLabel.text = classDetail?.required_resourses.first
            return cell
        } else if indexPath.row > (classDetail?.teachers.count ?? 0)+3 {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ClassChecklistTVCell") as? ClassChecklistTVCell else {return UITableViewCell()}
            cell.titleLabel.text = classDetail?.required_resourses[indexPath.row-((classDetail?.teachers.count ?? 0)+3)]
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

