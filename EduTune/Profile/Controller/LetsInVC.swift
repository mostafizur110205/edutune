//
//  LetsInVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 11/10/22.
//

import UIKit

class LetsInVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onFacebookButtonTap(_ sender: Any) {
        
    }
    
    @IBAction func onGoogleButtonTap(_ sender: Any) {
        
    }
    
    @IBAction func onAppleButtonTap(_ sender: Any) {
        
    }
    
    @IBAction func onSignInButtonTap(_ sender: Any) {
        if let viewC: LoginVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
            self.navigationController?.pushViewController(viewC, animated: true)
        }
    }
    
    @IBAction func onSignUpButtonTap(_ sender: Any) {
        if let viewC: SignupVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "SignupVC") as? SignupVC {
            self.navigationController?.pushViewController(viewC, animated: true)
        }
    }
    
}
