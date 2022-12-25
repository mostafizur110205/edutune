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
                     ["icon": "ic_wallet_outlined", "title": "Payment"],
                     ["icon": "ic_sheild_outlined", "title": "Terms & Conditions"],
                     ["icon": "ic_work", "title": "Refund Policy"],
                     ["icon": "ic_lock_outlined", "title": "Privacy Policy"],
                     ["icon": "ic_info_outlined", "title": "Help Center"],
                     ["icon": "ic_logout", "title": "Logout"],
                     ["icon": "ic_delete", "title": "Delete Account"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tabBarController?.tabBar.isHidden = true
        
        nameLabel.text = AppDelegate.shared().user?.username
        emailOrPhoneLabel.text = AppDelegate.shared().user?.email ?? AppDelegate.shared().user?.phone
        userImageView.sd_setImage(with: URL(string: AppDelegate.shared().user?.photo ?? "" ), placeholderImage: UIImage(named: "ic_user_placeholder"))
        
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func editProfile() {
        if let viewC: UpdateProfileVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "UpdateProfileVC") as? UpdateProfileVC {
            self.navigationController?.pushViewController(viewC, animated: true)
        }
    }
    
    func payment() {
        if let viewC: PaymentVC = UIStoryboard(name: "Other", bundle: nil).instantiateViewController(withIdentifier: "PaymentVC") as? PaymentVC {
            self.navigationController?.pushViewController(viewC, animated: true)
        }
    }
    
    func showContent(_ index: Int) {
        if let viewC: WebviewVC = UIStoryboard(name: "Other", bundle: nil).instantiateViewController(withIdentifier: "WebviewVC") as? WebviewVC {
            switch index {
            case 2:
                viewC.titleText = "Terms & Conditions"
                break
            case 3:
                viewC.titleText = "Refund Policy"
                break
            case 4:
                viewC.titleText = "Privacy Policy"
                break
            default:
                break
            }
            viewC.url = ""
            self.navigationController?.pushViewController(viewC, animated: true)
        }
    }
    
    func help() {
        if let viewC: HelpVC = UIStoryboard(name: "Other", bundle: nil).instantiateViewController(withIdentifier: "HelpVC") as? HelpVC {
            self.navigationController?.pushViewController(viewC, animated: true)
        }
    }
    
    func logout() {
        let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout ?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func deleteAccount() {
        let alertController = UIAlertController(title: "Delete account", message: "Are you sure you want to delete your account ?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            
        }))
        self.present(alertController, animated: true, completion: nil)
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
        if indexPath.row == 6 || indexPath.row == 7 {
            cellId = "ProfileTVCellE"
        }
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as? ProfileTVCell else {return UITableViewCell()}
        
        cell.iconImageView.image = icon
        cell.titleLabel.text = title
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            editProfile()
            break
        case 1:
            payment()
            break
        case 2,3,4:
            showContent(indexPath.row)
            break
        case 5:
            help()
            break
        case 6:
            logout()
            break
        case 7:
            deleteAccount()
            break
        default:
            break
        }
    }
    
}
