//
//  UpdateEmailPhone1VC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 1/1/23.
//

import UIKit

class UpdateEmailPhone1VC: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var phoneEmailIconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    var type: String = "email"
    var studentId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        if type == "email" {
            titleLabel.text = "Update Email"
            phoneEmailIconImageView.image = UIImage(named: "ic_email")
            textField.placeholder = "Email"
            subTitleLabel.text = "Please Enter Email"
            textField.keyboardType = .emailAddress
        } else {
            titleLabel.text = "Update Phone"
            phoneEmailIconImageView.image = UIImage(named: "ic_call_black")
            textField.placeholder = "Phone"
            subTitleLabel.text = "Please Enter Phone"
            textField.keyboardType = .phonePad
        }

    }

    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSendOTPButtonTap(_ sender: Any) {
        let value = textField.text!.trim
        if value.count>0 {
            let params = ["user_id": AppUserDefault.getUserId(), "student_id": studentId ?? -1, "type": type, "email_or_phone": value] as [String : Any]
            APIService.shared.sendOTP(params: params) { success in
                if let viewC: UpdateEmailPhone2VC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "UpdateEmailPhone2VC") as? UpdateEmailPhone2VC {
                    viewC.type = self.type
                    viewC.emailOrPhone = value
                    viewC.studentId = self.studentId
                    self.navigationController?.pushViewController(viewC, animated: true)
                }
            }
        } else {
            MakeToast.shared.makeNormalToast("\(type == "email" ? "Email" : "Phone") is empty")
        }
        
    }
    
}
