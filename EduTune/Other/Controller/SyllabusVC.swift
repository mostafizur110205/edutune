//
//  SyllabusVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 30/10/22.
//

import UIKit

class SyllabusVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.tabBarController?.tabBar.isHidden = true

    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }


}
