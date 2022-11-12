//
//  MyCourseVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 10/11/22.
//

import UIKit

class MyCourseVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    let sections = ["Live Classes":"See All", "Due Assignments":"See All", "Ongoing Courses":"Completed"]
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sHLabelLeft = UILabel()
        sHLabelLeft.text = Array(sections.keys)[section]
        sHLabelLeft.textColor = UIColor(named: "Grey900")
        sHLabelLeft.font = UIFont.boldSystemFont(ofSize: 20.0)
        sHLabelLeft.textAlignment = .left
        
        let button = UIButton()
        button.setTitleColor(UIColor(named: "Primary500"), for: .normal)
        button.setTitle(Array(sections.values)[section], for: .normal)
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
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ClassTVCell") as? ClassTVCell else {return UITableViewCell()}
        
        let classData = Class(json: [])
        cell.classData = classData
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
   
}


