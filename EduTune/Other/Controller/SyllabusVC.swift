//
//  SyllabusVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 30/10/22.
//

import UIKit

class SyllabusVC: UIViewController {

    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var groupNameLabel: UILabel!

    var syllabus: Syllabus?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.tabBarController?.tabBar.isHidden = true
       
        mainContentView.isHidden = true
        addShadow()
        getUserGoals()
    }
    
    func getUserGoals() {
        let params = ["user_id": AppUserDefault.getUserId(), "type": "get"] as [String: Any]
        APIService.shared.getSetUserGoals(params: params, completion: { syllabus in
            self.syllabus = syllabus
            self.mainContentView.isHidden = false
            self.updateUI()
        })
    }
    
    func addShadow() {
        mainContentView.layer.masksToBounds = false
        mainContentView.layer.shadowColor = UIColor.init(hex: "535990", alpha: 0.2).cgColor
        mainContentView.layer.cornerRadius = 10.0
        mainContentView.layer.shadowOffset = CGSize(width: 0, height: 3)
        mainContentView.layer.shadowRadius = 5
        mainContentView.layer.shadowOpacity = 0.5
    }
    
    func updateUI() {
        if let userClass = syllabus?.default_goals.first(where: { $0.id == syllabus?.goal_class_id }) {
            classNameLabel.text = userClass.name
            if let groupId = syllabus?.goal_group_id {
                groupView.isHidden = false
                if let userGroup = userClass.group.first(where: { $0.id == groupId }) {
                    groupNameLabel.text = userGroup.name
                }
            } else {
                groupView.isHidden = true
            }
        }
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func onChangeButtonTap(_ sender: Any) {
   
    }
    
}
