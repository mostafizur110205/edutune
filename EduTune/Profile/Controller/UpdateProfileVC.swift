//
//  UpdateProfileVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 11/10/22.
//

import UIKit

class UpdateProfileVC: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var guardianNameTextField: UITextField!
    @IBOutlet weak var guardianMobileTextField: UITextField!

    var userProfile: UserProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        dobTextField.delegate = self
        emailTextField.delegate = self
        mobileTextField.delegate = self
        guardianNameTextField.delegate = self
        guardianMobileTextField.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getProfile()
    }
    
    func getProfile() {
        let parms = ["user_id": AppUserDefault.getUserId()]
        APIService.shared.getProfile(params: parms) { user in
            self.userProfile = user
            self.updateUI()
        }
    }
    
    func updateUI() {
        AppDelegate.shared().user?.username = userProfile?.name
        AppDelegate.shared().user?.phone = userProfile?.mobile_number

        nameTextField.text = userProfile?.name
        dobTextField.text = userProfile?.dob
        emailTextField.text = userProfile?.email
        mobileTextField.text = userProfile?.mobile_number
        guardianNameTextField.text = userProfile?.guardian_name
        guardianMobileTextField.text = userProfile?.guardian_mobile
        
    }

    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onUpdateButtonTap(_ sender: Any) {
        let dob = dobTextField.text?.trim ?? ""
        let name = nameTextField.text?.trim ?? ""
        let guardianName = guardianNameTextField.text?.trim ?? ""
        let guardianNumber = guardianMobileTextField.text?.trim ?? ""

        let parms = ["user_id": AppUserDefault.getUserId(), "dob": dob, "name": name, "guardian_name": guardianName, "guardian_mobile": guardianNumber] as [String: Any]
        
        APIService.shared.updateProfile(params: parms) { success in
            AppDelegate.shared().user?.username = name
        }

    }
    
    func pickDob() {
        RPicker.selectDate(title: "", cancelText: "Cancel", datePickerMode: .date, minDate: nil, maxDate: Date(), didSelectDate: {[weak self] (selectedDate) in
            print(selectedDate)
            self?.dobTextField.text = selectedDate.formatDate(format: "dd-MM-yyyy")
        })
    }
    
    func changeEmail() {
        gotoInputFieldVC("email")
    }
    
    func changeMobile() {
        gotoInputFieldVC("phone")
    }
    
    func gotoInputFieldVC(_ type: String) {
        if let viewC: UpdateEmailPhone1VC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "UpdateEmailPhone1VC") as? UpdateEmailPhone1VC {
            viewC.type = type
            viewC.studentId = userProfile?.student_id
            self.navigationController?.pushViewController(viewC, animated: true)
        }
    }
    
}


extension UpdateProfileVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == dobTextField {
            pickDob()
            return false
        } else if textField == emailTextField {
            changeEmail()
            return false
        } else if textField == mobileTextField {
            changeMobile()
            return false
        }
        return true
    }
    
}
