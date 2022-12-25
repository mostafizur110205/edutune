//
//  HelpVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 30/10/22.
//

import UIKit

class HelpVC: UIViewController {

    var helpData: Help?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getHelpData()
    }
    
    func getHelpData() {
        APIService.shared.getHelpData { help in
            self.helpData = help
        }
    }

}
