//
//  MyCourseDetailsListVC.swift
//  EduTune
//
//  Created by Machtonis on 11/15/22.
//

import Foundation
import UIKit

import UIKit

class MyCourseDetailsListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var ongoingClass: OngoingClass?
    var classContents = [ClassContent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getMyCourseDetails()
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getMyCourseDetails() {
        let params = ["user_id": AppUserDefault.getUserId(), "class_id": ongoingClass?.id ?? -1]

        APIService.shared.getMyCourseWiseLessons(params: params, completion: { (clsContents, certificate_default_image) in
            
            self.classContents = clsContents
            self.tableView.reloadData()
            
        })
    }
    
}

extension MyCourseDetailsListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return classContents.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classContents[section].get_lectures.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "LessonHeaderCell") as? LessonHeaderCell else {return UITableViewCell()}
        let content = classContents[section]
        cell.titleLabel.text = content.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "LessonTVCell") as? LessonTVCell else {return UITableViewCell()}
        let content = classContents[indexPath.section].get_lectures[indexPath.row]
        cell.titleLabel.text = content.title
        
        var rowNumber = indexPath.row
        for i in 0..<indexPath.section {
            rowNumber += self.tableView.numberOfRows(inSection: i)
        }
        cell.countLabel.text = "\(rowNumber+1)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lecture = classContents[indexPath.section].get_lectures[indexPath.row]
        
        switch lecture.type {
        case MODEL_TEST_TYPE, QUIZ_TYPE, ASSESSMENT_TYPE:
            break
        case VIDEO_TYPE:
            if let viewC: VideoTypePreviewVC = self.storyboard?.instantiateViewController(withIdentifier: "VideoTypePreviewVC") as? VideoTypePreviewVC {
                viewC.lecture = lecture
                navigationController?.pushViewController(viewC, animated: true)
            }
            break
        case LIVE_TYPE, AUDIO_BOOK_TYPE, TRANSCRIPT_TYPE, NOTE_TYPE, PDF_BOOK_TYPE, LECTURE_SHEET_TYPE, SOLVE_CLASS_TYPE:
            if let viewC: LectureTypePreviewVC = self.storyboard?.instantiateViewController(withIdentifier: "LectureTypePreviewVC") as? LectureTypePreviewVC {
                viewC.lecture = lecture
                viewC.ongoingClass = self.ongoingClass
                navigationController?.pushViewController(viewC, animated: true)
            }
            break
        default:
            break
        }
    }
    
}
