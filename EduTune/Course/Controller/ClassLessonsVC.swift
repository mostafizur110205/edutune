//
//  ClassLessonsVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 22/10/22.
//

import UIKit
import SJSegmentedScrollView

class ClassLessonsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lessonCountLabel: UILabel!
    
    var classDetail: ClassDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        var classCount = 0
        
        for classes in classDetail?.get_class_contents ?? [] {
            classCount += classes.get_lectures.count
        }
        lessonCountLabel.text = "\(classCount) lessons"
    }
    
    @IBAction func onSeeAllButtonTap(_ sender: Any) {
        if let viewC: AllLessonsVC = UIStoryboard(name: "Course", bundle: nil).instantiateViewController(withIdentifier: "AllLessonsVC") as? AllLessonsVC {
            viewC.classContents = classDetail?.get_class_contents ?? []
            self.navigationController?.pushViewController(viewC, animated: true)
        }
    }
    
}

extension ClassLessonsVC: SJSegmentedViewControllerViewSource {
    
    func viewForSegmentControllerToObserveContentOffsetChange() -> UIView {
        return tableView
    }
}

extension ClassLessonsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return classDetail?.get_class_contents.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classDetail?.get_class_contents[section].get_lectures.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "LessonHeaderCell") as? LessonHeaderCell else {return UITableViewCell()}
        let content = classDetail?.get_class_contents[section]
        cell.titleLabel.text = content?.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "LessonTVCell") as? LessonTVCell else {return UITableViewCell()}
        let content = classDetail?.get_class_contents[indexPath.section].get_lectures[indexPath.row]
        cell.titleLabel.text = content?.title
        
        var rowNumber = indexPath.row
        for i in 0..<indexPath.section {
            rowNumber += self.tableView.numberOfRows(inSection: i)
        }
        cell.countLabel.text = "\(rowNumber+1)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

