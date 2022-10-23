//
//  CreateNewPassVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 11/10/22.
//

import UIKit

class CreateNewPassVC: UIViewController {
   
    @IBOutlet weak var newPassTextField: UITextField!
    @IBOutlet weak var cofirmNewPassTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onContinueButtonTap(_ sender: Any) {

    }
    
    @IBAction func onRememberButtonTap(_ sender: Any) {

    }
    
    @IBAction func onNewPasssEysButtonTap(_ sender: Any) {

    }
    
    @IBAction func onConfirmNewPassEyeButtonTap(_ sender: Any) {

    }
    
}
