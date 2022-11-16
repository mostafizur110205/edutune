//
//  InputPromoVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 16/11/22.
//

import UIKit

protocol InputPromoVCDelegate {
    func didApplyButtonTap(_ code: String)
}

class InputPromoVC: UIViewController {

    @IBOutlet weak var codeTextField: UITextField!
   
    var delegate: InputPromoVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onCancelButtonTap(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func onApplyButtontap(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.didApplyButtonTap(self.codeTextField.text ?? "")
        }
    }
    
}
