//
//  NotificationsVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 23/10/22.
//

import UIKit

class NotificationsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var notifications = [Notification]()
    let icons = ["ic_noti_blue", "ic_noti_green", "ic_noti_yellow", "ic_noti_red", "ic_noti_orange"]
    
    var currentPage = 1
    var lastPage = 1
    var isAPICalling: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self

        getNotifications(page: currentPage)
    }
    
    func getNotifications(page: Int) {
        let params = ["user_id": AppUserDefault.getUserId()]
        APIService.shared.getNotifications(page: page, params: params) { notifications, currentPage, lastPage in
            self.currentPage = currentPage
            self.lastPage = lastPage
            
            self.isAPICalling = false
            if page == 1 {
                self.notifications = notifications
            } else {
                self.notifications += notifications
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension NotificationsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "NotificationTVCell") as? NotificationTVCell else {return UITableViewCell()}
        
        cell.notification = notifications[indexPath.row]
        cell.cellImageView.image = UIImage(named: icons[indexPath.row%5])
        if indexPath.row == notifications.count-1 && currentPage < lastPage {
            getNotifications(page: currentPage + 1)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let viewC: NotificationDetailsVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "NotificationDetailsVC") as? NotificationDetailsVC {
            viewC.modalTransitionStyle   = .crossDissolve;
            viewC.modalPresentationStyle = .overCurrentContext
            viewC.notification = notifications[indexPath.row]
            viewC.icon = UIImage(named: icons[indexPath.row%5])
            self.present(viewC, animated: true, completion: nil)
        }
    }
    
}
