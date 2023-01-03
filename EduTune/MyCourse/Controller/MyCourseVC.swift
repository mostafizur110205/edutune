//
//  MyCourseVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 10/11/22.
//

import UIKit

class MyCourseVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var sections: [String] = []
    var liveClasses = [LiveClass]()
    var dueAssignments = [DueAssignments]()
    var ongoingClasses = [OngoingClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
        
        getMyCourses()

    }
    
    @IBAction func onSearchButtonTap(_ sender: Any) {
        if let viewC: SearchVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? SearchVC {
            self.navigationController?.pushViewController(viewC, animated: true)
        }
    }
    
    func getMyCourses() {
        
        if AppUserDefault.getIsLoggedIn() {
            var params = [String: Any]()
            params["user_id"] = AppUserDefault.getUserId()
            APIService.shared.getMyCourse(params: params, completion: { liveC, dAssignments, ogClass  in
                
                print(liveC.count)
                self.liveClasses = liveC.filter({ $0.status != .finished })
                self.sections.append(MyCourseType.live)
                
                print(dAssignments.count)
                self.dueAssignments = dAssignments;
                self.sections.append(MyCourseType.due)
                
                print(ogClass.count)
                self.ongoingClasses = ogClass;
                self.sections.append(MyCourseType.onGoing)
                
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let sectionKey = Array(self.sections.keys)[section]
        let sectionKey = self.sections[section]
        if sectionKey == MyCourseType.live {
            return self.liveClasses.count
        } else if sectionKey == MyCourseType.due {
            return self.dueAssignments.count
        } else if sectionKey == MyCourseType.onGoing {
            return self.ongoingClasses.count
        }
        else{return 0}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionKey = self.sections[indexPath.section]
        if sectionKey == MyCourseType.live {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "LiveClassTVCell") as? LiveClassTVCell else {return UITableViewCell()}
            
            cell.classData = self.liveClasses[indexPath.row]
            return cell
        } else if sectionKey == MyCourseType.due {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "DueAssignmentsTVCell") as? DueAssignmentsTVCell else {return UITableViewCell()}
            cell.classData = self.dueAssignments[indexPath.row]
            return cell
        } else  if sectionKey == MyCourseType.onGoing {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "OngoingTVCell") as? OngoingTVCell else {return UITableViewCell()}
            
            cell.classData = self.ongoingClasses[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sectionKey = self.sections[indexPath.section]
        if sectionKey == MyCourseType.live {
            let liveClass = self.liveClasses[indexPath.row]

            if liveClass.status == .live {
                if let viewC: ZoomCallVC = self.storyboard?.instantiateViewController(withIdentifier: "ZoomCallVC") as? ZoomCallVC {
                    let liveClass = self.liveClasses[indexPath.row]
                    viewC.host_link = liveClass.hostLink
                    viewC.host_name = liveClass.hostName
                    viewC.zoom_sdk_app_key = liveClass.zoom_sdk_app_key
                    viewC.zoom_sdk_app_secret = liveClass.zoom_sdk_app_secret

                    navigationController?.pushViewController(viewC, animated: true)
                }
            }
        } else if sectionKey == MyCourseType.due {
            if let viewC: ExamTypePreviewVC = self.storyboard?.instantiateViewController(withIdentifier: "ExamTypePreviewVC") as? ExamTypePreviewVC {
                viewC.classData = self.dueAssignments[indexPath.row]
                navigationController?.pushViewController(viewC, animated: true)
            }
        } else {
            if let viewC: MyCourseDetailsListVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCourseDetailsListVC") as? MyCourseDetailsListVC {
                viewC.ongoingClass = self.ongoingClasses[indexPath.row]
                navigationController?.pushViewController(viewC, animated: true)
            }
        }
    }
    
}

struct MyCourseType{
    static let live = "live"
    static let due = "due"
    static let onGoing = "onGoing"
}
