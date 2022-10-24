//
//  SplashVC.swift
//  Trendit
//
//  Created by Mostafizur Rahman on 27/6/22.
//

import UIKit

class SplashVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //  self.getAppVersionInfo()
        
        getBannerData()
        
    }
    
    func getBannerData() {
        APIService.shared.getOnboardData { onboardData in
            if AppUserDefault.getIsLoggedIn() {
                var params = ["user_id": AppUserDefault.getUserId(), "language": AppUserDefault.getLanguage()]
                if let email = AppUserDefault.getEmail(), email.count>0 {
                    params["mobile_or_email"] = email
                } else  if let phone = AppUserDefault.getPhone(), phone.count>0 {
                    params["mobile_or_email"] = phone
                }
                APIService.shared.relogin(params: params, completion: { user in
                    self.animate(onboardData)
                })
            } else {
                self.animate(onboardData)
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func showUpdateAlert(_ isForce: Bool) {
        //        let alertController = UIAlertController(title: "Update available", message: "An update is available. Please update your app !", preferredStyle: .alert)
        //
        //        let appUrl = "https://apps.apple.com/us/app/id1628444676"
        //        let updateAction = UIAlertAction(title: "Update", style: .default, handler: { (alert) in
        //            if let url = URL(string: appUrl) {
        //                if UIApplication.shared.canOpenURL(url) {
        //                    UIApplication.shared.open(url)
        //                }
        //            }
        //        })
        //        alertController.addAction(updateAction)
        //
        //        if !isForce {
        //            let cancel = UIAlertAction(title: "Not now", style: .cancel) { (action) in
        //                self.goForNextVC()
        //            }
        //            alertController.addAction(cancel)
        //
        //        }
        //
        //        present(alertController, animated: true, completion: nil)
    }
    
    func getAppVersionInfo() {
        
        //        APIService.shared.getAppVersionInfo { json in
        //
        //            let appStoreVersion = json["ios_app_version"].string ?? "0.0.0"
        //            let isForceUpdate = json["ios_force_update"].boolValue
        //
        //            let currentVersion = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "0.0.0"
        //
        //            print("Current version = \(currentVersion)")
        //            print("Live version = \(appStoreVersion)")
        //
        //            if appStoreVersion.compare(currentVersion, options: .numeric) == .orderedDescending {
        //                self.showUpdateAlert(isForceUpdate)
        //            } else {
        //                self.animate()
        //            }
        //
        //        }
        
    }
    
    func goForNextVC(_ onboardData: [OnboardData]) {
        if AppUserDefault.getIsAppOpened() {
            if let viewC: TabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC {
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = viewC
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.makeKeyAndVisible()
            }
        } else {
            if let viewC: IntroVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IntroVC") as? IntroVC {
                viewC.dataTuto = onboardData
                let navVC = UINavigationController(rootViewController: viewC)
                navVC.navigationBar.tintColor = .black
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = navVC
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.makeKeyAndVisible()
            }
        }
        
    }
    
    func animate(_ onboardData: [OnboardData]) {
        
        UIView.animate(withDuration: 1, animations: {
            self.imageView.transform = CGAffineTransform.identity.scaledBy(x: 150, y: 150)
            self.imageView.alpha = 0
            
        }, completion: { (success) in
            if success {
                DispatchQueue.main.async {
                    self.goForNextVC(onboardData)
                }
            }
        })
    }
}
