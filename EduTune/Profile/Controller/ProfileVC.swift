//
//  ProfileVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 30/10/22.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailOrPhoneLabel: UILabel!
    
    let tableData = [["icon": "ic_profile_outlined", "title": "Edit Profile"],
                     ["icon": "ic_notification_outlined", "title": "Notification"],
                     ["icon": "ic_wallet_outlined", "title": "Payment"],
                     ["icon": "ic_sheild_outlined", "title": "Security"],
                     ["icon": "ic_language_outlined", "title": "Language"],
                     ["icon": "ic_eye_outlined", "title": "Dark Mode"],
                     ["icon": "ic_lock_outlined", "title": "Privacy Policy"],
                     ["icon": "ic_info_outlined", "title": "Help Center"],
                     ["icon": "ic_people_outlined", "title": "Invite Friends"],
                     ["icon": "ic_logout", "title": "Logout"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tabBarController?.tabBar.isHidden = true
        
        nameLabel.text = AppDelegate.shared().user?.username
        emailOrPhoneLabel.text = AppDelegate.shared().user?.email ?? AppDelegate.shared().user?.phone
        userImageView.sd_setImage(with: URL(string: AppDelegate.shared().user?.photo ?? "" ), placeholderImage: nil)
        
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = tableData[indexPath.row]
        let icon = UIImage(named: cellData["icon"] ?? "")
        let title = cellData["title"]
        
        var cellId = "ProfileTVCell"
        if title == "Language" {
            cellId = "ProfileTVCellL"
        } else if title == "Dark Mode" {
            cellId = "ProfileTVCellT"
        } else if title == "Logout" {
            cellId = "ProfileTVCellE"
        }
        
        guard var cell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as? ProfileTVCell else {return UITableViewCell()}

        
        cell.iconImageView.image = icon
        cell.titleLabel.text = title
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
