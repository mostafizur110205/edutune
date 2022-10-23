//
//  TopMentorsVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 13/10/22.
//

import UIKit

class TopMentorsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var topEducators = [Teacher]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getTopEducators()
        
    }

    func getTopEducators() {
        let params = ["type": "TOP_EDUCATORS"]
        APIService.shared.getTopEducators(params: params) { data in
            self.topEducators = data
            self.tableView.reloadData()
        }
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSearchButtonTap(_ sender: Any) {
        
    }
    
}

extension TopMentorsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topEducators.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "MentorTVCell") as? MentorTVCell else {return UITableViewCell()}
        
        let teacher = topEducators[indexPath.row]
        cell.teacher = teacher
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppDelegate.shared().openMentorProfileVC(navigationController: self.navigationController, mentor: topEducators[indexPath.item])
    }
    
}

