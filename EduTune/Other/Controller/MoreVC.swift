//
//  MoreVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 30/10/22.
//

import UIKit
import SafariServices

class MoreVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let tableData = [[["icon": "", "title": "Certificates"], ["icon": "", "title": "Syllabus"], ["icon": "", "title": "Bookmark"], ["icon": "", "title": "Notification"]],
                     [["icon": "", "title": "Profile"], ["icon": "", "title": "Referral"], ["icon": "", "title": "Submit Problem"], ["icon": "", "title": "Message"]],
                     [["icon": "", "title": "Facebook"], ["icon": "", "title": "LinkedIn"], ["icon": "", "title": "Youtube"], ["icon": "", "title": "Rate us"]]]
    
    let sectionTitles = ["ACADEMIC OPTIONS", "IMPORTANT LINK", "SOCIAL DETAILS"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
}

extension MoreVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "MoreSectionTVCell") as? MoreSectionTVCell else {return UITableViewCell()}
        cell.titleLabel.text = sectionTitles[section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "MoreTVCell") as? MoreTVCell else {return UITableViewCell()}
        
        let cellData = tableData[indexPath.section][indexPath.row]
        //        cell.iconImageView.image = UIImage(named: cellData["icon"] ?? "")
        cell.titleLabel.text = cellData["title"]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                // Certificates
                break
            case 1:
                // Syllabus
                break
            case 2:
                if let viewC: BookmarksVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "BookmarksVC") as? BookmarksVC {
                    self.navigationController?.pushViewController(viewC, animated: true)
                }
                break
            case 3:
                if let viewC: NotificationsVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC {
                    self.navigationController?.pushViewController(viewC, animated: true)
                }
                break
            default:
                break
            }
        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                // profile
                break
            case 1:
                // Referral
                break
            case 2:
                // Submit problem
                break
            case 3:
                // Message
                break
            default:
                break
            }
        } else if indexPath.section == 2 {
            switch indexPath.row {
            case 0:
                let safariVC = SFSafariViewController(url: URL(string: "https://facebook.com/edutuneapp")!)
                safariVC.delegate = self
                self.present(safariVC, animated: true, completion: nil)
                break
            case 1:
                let safariVC = SFSafariViewController(url: URL(string: "https://www.linkedin.com/company/edutune")!)
                safariVC.delegate = self
                self.present(safariVC, animated: true, completion: nil)
                break
            case 2:
                let safariVC = SFSafariViewController(url: URL(string: "https://www.youtube.com/channel/UCYLLXnYivNnNIqMwSls1e4Q")!)
                safariVC.delegate = self
                self.present(safariVC, animated: true, completion: nil)
                break
            case 3:
                guard let url = URL(string : "itms-apps://itunes.apple.com/app/id1473824619?action=write-review") else {return}
                UIApplication.shared.open(url, options: [:])
                break
            default:
                break
            }
        }
    }
    
}

extension MoreVC: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
