//
//  LectureTypePreviewVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 6/12/22.
//

import UIKit

class LectureTypePreviewVC: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var lecture: Lecture?
    var ongoingClass: OngoingClass?


    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true

        updateUI()
    }
    
//    func getLectureDetails() {
//        let params = ["user_id": AppUserDefault.getUserId(), "class_id": lecture?.get_class_content_view?.class_id ?? -1, "class_content_lecture_id": lecture?.id ?? -1, "lecture_type": lecture?.type ?? -1]
//
//        APIService.shared.getMyCourseWiseLessonsLecture(params: params) { lectures in
//            if lectures.count>0 {
//                self.lecture = lectures.first
//                self.updateUI()
//            }
//
//        }
//    }
    

    func updateUI() {
        previewImageView.sd_setImage(with: URL(string: ongoingClass?.photo ?? "" ), placeholderImage: nil)
        titleLabel.text = lecture?.title
        nameLabel.text = lecture?.title
        categoryLabel.text = "  \(ongoingClass?.name ?? "")  "
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
