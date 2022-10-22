//
//  MentorProfileVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 22/10/22.
//

import UIKit

class MentorProfileVC: UIViewController {

    var teacher: Teacher?
    var classes = [Class]()

    var currentPage = 1
    var lastPage = 1
    var isAPICalling: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func getMentorDetails(page: Int) {
        if isAPICalling {
            return
        }
        let params = ["teacher_id": "6352"]
        
        APIService.shared.getMentorDetails(page: page, params: params) { teacher, classes, currentPage, lastPage in
            
            self.currentPage = currentPage
            self.lastPage = lastPage
            
            self.isAPICalling = false
            
            if page == 1 {
                self.teacher = teacher
                self.classes = classes
            } else {
                self.classes += classes
            }
        }
        
    }

}
