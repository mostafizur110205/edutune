//
//  ForgotPassVerifyVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 11/10/22.
//

import UIKit

class ForgotPassVerifyVC: UIViewController {

    @IBOutlet weak var phoneLabel: UILabel! // Code has been send to +1 111 ******99
    @IBOutlet weak var resendLabel: UILabel! // Resend code in 55 s
    @IBOutlet weak var otpTextField: OTPTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onContinueButtonTap(_ sender: Any) {

    }
    
    @IBAction func onResendButtonTap(_ sender: Any) {

    }
    

}
