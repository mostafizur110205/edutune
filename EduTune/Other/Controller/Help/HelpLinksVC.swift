//
//  HelpLinksVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 25/12/22.
//

import UIKit

class HelpLinksVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var helpData: Help?
    
    let tableData = [["icon": "ic_headphone", "title": "Customer Service"],
                     ["icon": "ic_whatsapp", "title": "WhatsApp"],
                     ["icon": "ic_website", "title": "Website"],
                     ["icon": "ic_facebook_blue", "title": "Facebook"],
                     ["icon": "ic_youtube", "title": "Youtube"],
                     ["icon": "ic_linkedin", "title": "LinkedIn"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func goToWebviewVC(_ title: String, urlString: String) {
        if let viewC: WebviewVC = UIStoryboard(name: "Other", bundle: nil).instantiateViewController(withIdentifier: "WebviewVC") as? WebviewVC {
            viewC.titleText = title
            viewC.url = urlString
            self.navigationController?.pushViewController(viewC, animated: true)
        }
    }
    
    func call(_ number: String) {
        let trimmedPhoneNumber = number
        if let url: URL = URL(string: "telprompt://\(trimmedPhoneNumber)"), UIApplication.shared.canOpenURL(url) == true{
            UIApplication.shared.open(url)
        }
    }
    
    func openWhatsApp(_ number: String) {
        let urlWhats = "whatsapp://send?phone=+88\(number)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                }
                else {
                    MakeToast.shared.makeNormalToast("WhatsApp is not installed")
                    print("Install Whatsapp")
                }
            }
        }
    }
    
}

extension HelpLinksVC: UITableViewDelegate, UITableViewDataSource {
    
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
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "MoreTVCell") as? MoreTVCell else {return UITableViewCell()}
        
        let cellData = tableData[indexPath.row]
        cell.iconImageView.image = UIImage(named: cellData["icon"] ?? "")
        cell.titleLabel.text = cellData["title"]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            call(helpData?.customer_service ?? "")
            break
        case 1:
            openWhatsApp(helpData?.whatsapp ?? "")
            break
        case 2:
            goToWebviewVC("Website", urlString: helpData?.website ?? "")
            break
        case 3:
            goToWebviewVC("Facebook", urlString: helpData?.facebook_page ?? "")
            break
        case 4:
            goToWebviewVC("Youtube", urlString: helpData?.youtube_channel ?? "")
            break
        case 5:
            goToWebviewVC("LinkedIn", urlString: helpData?.linkedin_page ?? "")
            break
        default:
            break
        }
        
    }
    
}
