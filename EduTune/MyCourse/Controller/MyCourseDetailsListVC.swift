//
//  MyCourseDetailsListVC.swift
//  EduTune
//
//  Created by Machtonis on 11/15/22.
//

import Foundation
import UIKit

class MyCourseDetailsListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navTitle: UILabel!
    var ongoingClass: OngoingClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ongoingClass \(String(describing: ongoingClass))")
        navTitle.text = ongoingClass?.name ?? ""
        tableView.reloadData()
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension MyCourseDetailsListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.ongoingClass?.getClassContents?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.ongoingClass?.getClassContents?[section].title ?? ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ongoingClass?.getClassContents?[section].get_lectures.count ?? 0
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
    }
    
    
}
