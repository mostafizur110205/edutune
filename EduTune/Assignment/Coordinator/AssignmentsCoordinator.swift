//
//  AssignmentsCoordinator.swift
//  EduTune
//
//  Created by DH on 13/12/22.
//

import UIKit

class AssignmentsCoordinator {
    
    var controller: UIViewController
    var viewModel: AssignmentsViewModel
    
    init (controller: UIViewController, viewModel: AssignmentsViewModel) {
        self.controller = controller
        self.viewModel = viewModel
    }
    
    public func openController() {
        
        guard let viewController: AssignmentsVC = UIStoryboard(name: "Assignments", bundle: nil).instantiateViewController(withIdentifier: "AssignmentsVC") as? AssignmentsVC else {return}
        viewController.viewModel = viewModel
        controller.navigationController?.pushViewController(viewController, animated: true)
    }
}

