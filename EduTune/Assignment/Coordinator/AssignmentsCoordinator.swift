//
//  AssignmentsCoordinator.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 13/12/22.
//

import UIKit

class AssignmentsCoordinator {
    
    var controller: UIViewController
    var viewModel: AssignmentsViewModel
    var assignment: DueAssignments?

    init (controller: UIViewController, viewModel: AssignmentsViewModel, assignment: DueAssignments?) {
        self.controller = controller
        self.viewModel = viewModel
        self.assignment = assignment
    }
    
    public func openController() {
        guard let viewController: AssignmentsVC = UIStoryboard(name: "Assignments", bundle: nil).instantiateViewController(withIdentifier: "AssignmentsVC") as? AssignmentsVC else {return}
        viewController.viewModel = viewModel
        viewController.assignment = assignment
        controller.navigationController?.pushViewController(viewController, animated: true)
    }
}

