//
//  MoreVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 30/10/22.
//

import UIKit

class MoreVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let tableData = [[["icon": "ic_certificate", "title": "Certificates"],
                      ["icon": "ic_syllabus", "title": "Syllabus"],
                      ["icon": "ic_bookmarked", "title": "Bookmark"],
                      ["icon": "ic_notification", "title": "Notification"]],
                     [["icon": "ic_profile", "title": "Profile"],
                      ["icon": "ic_problem", "title": "Submit Problem"]],
                     [["icon": "ic_facebook_blue", "title": "Facebook"],
                      ["icon": "ic_linkedin", "title": "LinkedIn"],
                      ["icon": "ic_youtube", "title": "Youtube"],
                      ["icon": "ic_rate", "title": "Rate us"]]]
    
    let sectionTitles = ["ACADEMIC OPTIONS", "IMPORTANT LINK", "SOCIAL DETAILS"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func goToWebviewVC(_ title: String, urlString: String) {
        if let viewC: WebviewVC = UIStoryboard(name: "Other", bundle: nil).instantiateViewController(withIdentifier: "WebviewVC") as? WebviewVC {
            viewC.titleText = title
            viewC.url = urlString
            self.navigationController?.pushViewController(viewC, animated: true)
        }
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
        cell.iconImageView.image = UIImage(named: cellData["icon"] ?? "")
        cell.titleLabel.text = cellData["title"]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                if let viewC: CertificatesVC = UIStoryboard(name: "Other", bundle: nil).instantiateViewController(withIdentifier: "CertificatesVC") as? CertificatesVC {
                    self.navigationController?.pushViewController(viewC, animated: true)
                }
                break
            case 1:
                if let viewC: SyllabusVC = UIStoryboard(name: "Other", bundle: nil).instantiateViewController(withIdentifier: "SyllabusVC") as? SyllabusVC {
                    self.navigationController?.pushViewController(viewC, animated: true)
                }
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
                if let viewC: ProfileVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC {
                    self.navigationController?.pushViewController(viewC, animated: true)
                }
                break
            case 1:
                if let viewC: ProblemsVC = UIStoryboard(name: "Other", bundle: nil).instantiateViewController(withIdentifier: "ProblemsVC") as? ProblemsVC {
                    self.navigationController?.pushViewController(viewC, animated: true)
                }
                break
            default:
                break
            }
        } else if indexPath.section == 2 {
            switch indexPath.row {
            case 0:
                goToWebviewVC("Facebook", urlString: "https://facebook.com/edutuneapp")
                break
            case 1:
                goToWebviewVC("LinkedIn", urlString: "https://www.linkedin.com/company/edutune")
                break
            case 2:
                goToWebviewVC("Youtube", urlString: "https://www.youtube.com/channel/UCYLLXnYivNnNIqMwSls1e4Q")
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
