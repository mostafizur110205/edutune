//
//  TextViewVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 30/10/22.
//

import UIKit
import WebKit

class WebviewVC: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    var url: String = "https://www.google.com"
    var titleText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        titleLabel.text = titleText
        
        if url == "" {
            getData()
        } else if url.contains("http") {
            loadURL()
        }
        
    }
    
    func getData() {
        APIService.shared.getHelpData { help in
            switch self.titleText {
            case "Terms & Conditions":
                self.loadHTML(help?.terms_and_conditions ?? "")
                break
            case "Refund Policy":
                self.loadHTML(help?.refund_policy ?? "")
                break
            case "Privacy Policy":
                self.loadHTML(help?.privacy_policy ?? "")
                break
            default:
                break
            }
        }
    }
    
    func loadHTML(_ html: String) {
        let topPadding = AppDelegate.shared().topInset
        let bottomPadding = AppDelegate.shared().bottomInset
        
        let screenSize = UIScreen.main.bounds.size
        
        let frame = CGRect(x: 0, y: 0, width: screenSize.width-20, height: screenSize.height-topPadding-bottomPadding-44);
        
        let jScript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
        let wkUScript = WKUserScript(source: jScript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        let wkUController = WKUserContentController()
        wkUController.addUserScript(wkUScript)
        
        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.userContentController = wkUController
        
        let webPageView = WKWebView(frame: frame, configuration: wkWebConfig)
        
        self.contentView.addSubview(webPageView)
        
        webPageView.loadHTMLString(html, baseURL: nil)

    }
    
    func loadURL() {
        let topPadding = AppDelegate.shared().topInset
        let bottomPadding = AppDelegate.shared().bottomInset
        
        let screenSize = UIScreen.main.bounds.size
        
        let frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height-topPadding-bottomPadding-44);
        
        let jScript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
        let wkUScript = WKUserScript(source: jScript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        let wkUController = WKUserContentController()
        wkUController.addUserScript(wkUScript)
        
        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.userContentController = wkUController
        
        let webPageView = WKWebView(frame: frame, configuration: wkWebConfig)
        
        self.contentView.addSubview(webPageView)
        
        let request = URLRequest(url: URL(string: url)!)
        webPageView.load(request)
        
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


