//
//  UpdateEmailPhone2VC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 1/1/23.
//

import UIKit

class UpdateEmailPhone2VC: UIViewController {

    @IBOutlet weak var otpTextField: OTPTextView!
    @IBOutlet weak var subTitleLabel: UILabel!

    var type: String = "email"
    var studentId: Int?
    var emailOrPhone: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        otpTextField.BlocksNo = 4
        otpTextField.isPasswordProtected = false
        otpTextField.delegate = self
        
        subTitleLabel.text = "Code has been sent to\n\(emailOrPhone)"
        
    }

    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onContinueButtonTap(_ sender: Any) {
        verify(otpTextField.getNumber()!)
    }
    
    func verify(_ code: String){
        let params = ["user_id": AppUserDefault.getUserId(), "student_id": studentId ?? -1, "type": type, "email_or_phone": emailOrPhone, "otp": code] as [String: Any]

        APIService.shared.updateEmailPhone(params: params, completion: { success in
            guard let viewC = self.navigationController?.viewControllers.first(where: { $0 is UpdateProfileVC}) as? UpdateProfileVC else { return }
            self.navigationController?.popToViewController(viewC, animated: true)

        })
    }
    
}

extension UpdateEmailPhone2VC: OTPTextViewDelegate {
    func OTPTextViewResult(number: String?) {
        self.view.endEditing(true)
        verify(number!)
    }
}
