//
//  MyCourseVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 10/11/22.
//

import UIKit

class MyCourseVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    //var sections:[String: String] = [:]
    var sections:[String] = []
    var dueAssignments = [DueAssignments]()
    var liveClasses = [LiveClass]()
    var ongoingClasses = [OngoingClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMyCourses()
    }
    
    func getMyCourses() {
        
        if AppUserDefault.getIsLoggedIn() {
            var params = [String: Any]()
            params["user_id"] = AppUserDefault.getUserId()
            APIService.shared.getMyCourse(params: params, completion: {liveC, dAssignments, ogClass  in
                
                if let lClasses = liveC {
                    self.liveClasses = lClasses;
                    self.sections.append(MyCourseType.live)
                    
                    //self.sections["Live Classes"] = "See All"
                }
                
                if let dueAssignments = dAssignments {
                    print(dueAssignments.count)
                    self.dueAssignments = dueAssignments;
                    self.sections.append(MyCourseType.due)

                   // self.sections["Due Assignments"] = "See All"
                }
                
                if let ogClasses = ogClass {
                    print(ogClasses.count)
                    self.ongoingClasses = ogClasses;
                    self.sections.append(MyCourseType.onGoing)

                    //self.sections["Ongoing Courses"] = ""
                }
                self.sections.isEmpty ? self.tableView.isHidden = true : self.tableView.reloadData()
                
            })
        } else {
            tableView.isHidden = true
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let text = self.sections[section] == MyCourseType.live ? "Live Classes" : (self.sections[section] == MyCourseType.due ? "Due Assignments" : "Ongoing Courses")
        let sHLabelLeft = UILabel()
        //sHLabelLeft.text = Array(sections.keys)[section]
        sHLabelLeft.text = text
        sHLabelLeft.textColor = UIColor(named: "Grey900")
        sHLabelLeft.font = UIFont.boldSystemFont(ofSize: 20.0)
        sHLabelLeft.textAlignment = .left
        
        let btnText = (self.sections[section] == MyCourseType.live || self.sections[section] == MyCourseType.due) ? "See All" : ""
        let button = UIButton()
        button.setTitleColor(UIColor(named: "Primary500"), for: .normal)
        //button.setTitle(Array(sections.values)[section], for: .normal)
        button.setTitle(btnText, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        //button.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 10
        stackView.addArrangedSubview(sHLabelLeft)
        stackView.addArrangedSubview(button)
        
        return stackView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionKey = self.sections[indexPath.section]
        if sectionKey == MyCourseType.due{
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "DueAssignmentsTVCell") as? DueAssignmentsTVCell else {return UITableViewCell()}
            
            cell.classData = self.dueAssignments[indexPath.row]
            return cell
        }else  if sectionKey == MyCourseType.live{
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "LiveClassTVCell") as? LiveClassTVCell else {return UITableViewCell()}
            
            cell.classData = self.liveClasses[indexPath.row]
            return cell
        }else  if sectionKey == MyCourseType.onGoing{
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "OngoingTVCell") as? OngoingTVCell else {return UITableViewCell()}
            
            cell.classData = self.ongoingClasses[indexPath.row]
            return cell
        }
       
        return UITableViewCell()
//        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ClassTVCell") as? ClassTVCell else {return UITableViewCell()}
//
//        let classData = Class(json: [])
//        cell.classData = classData
//        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let sectionKey = Array(self.sections.keys)[section]
        let sectionKey = self.sections[section]
        if sectionKey == MyCourseType.due{
            return self.dueAssignments.count
        } else if sectionKey == MyCourseType.live{
            return self.liveClasses.count
        }else if sectionKey == MyCourseType.onGoing{
            return self.ongoingClasses.count
        }
        else{return 0}
    }
    
    
    
    
}


struct MyCourseType{
    static let live = "live"
    static let due = "due"
    static let onGoing = "onGoing"
    
}
