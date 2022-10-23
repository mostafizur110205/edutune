//
//  VerificationVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 11/10/22.
//

import UIKit

class VerificationVC: UIViewController {
    
    @IBOutlet weak var otpTextField: OTPTextView!
    
    var params = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        otpTextField.BlocksNo = 4
        otpTextField.isPasswordProtected = false
        otpTextField.delegate = self
        
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onContinueButtonTap(_ sender: Any) {
        verify(otpTextField.getNumber()!)
    }
    
    func verify(_ code: String){
        params["otp"] = code
        
        APIService.shared.signupStep2(params: params) { succes in
            if let viewC: TabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC {
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = viewC
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.makeKeyAndVisible()
            }
        }
    }
    
}

extension VerificationVC: OTPTextViewDelegate {
    func OTPTextViewResult(number: String?) {
        self.view.endEditing(true)
        verify(number!)
    }
}
