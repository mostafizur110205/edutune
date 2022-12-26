//
//  ProblemDetailsVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 27/12/22.
//

import UIKit

class ProblemDetailsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
