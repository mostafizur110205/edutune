//
//  InvoiceVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 25/12/22.
//

import UIKit

class InvoiceVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
