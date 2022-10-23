//
//  LoginVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 11/10/22.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        var params = ["mobile_or_email": phoneTextField.text!]
        
        APIService.shared.signupStep1(params: params) { token in
            if let viewC: VerificationVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "VerificationVC") as? VerificationVC {
                params["token"] = token
                viewC.params = params
                self.navigationController?.pushViewController(viewC, animated: true)
            }
        }
    }
    
    @IBAction func onSignUpButtonTap(_ sender: Any) {
        if let viewC: SignupVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "SignupVC") as? SignupVC {
            self.navigationController?.pushViewController(viewC, animated: true)
        }
    }
    
    @IBAction func onSignInPassButtonTap(_ sender: Any) {
        
    }
    
    @IBAction func onForgotPassButtonTap(_ sender: Any) {
        
    }
    
}
