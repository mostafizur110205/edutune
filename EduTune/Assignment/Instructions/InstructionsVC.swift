//
//  BottomViewController.swift
//  BRQBottomSheetExample
//
//  Created by Bruno Faganello Neto on 17/07/19.
//  Copyright © 2019 Faganello. All rights reserved.
//

import UIKit

class InstructionsVC: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    
    var bottomSheetVC: BottomSheetVC?
    var superView: UIViewController?
    var viewModel: AssignmentsViewModel
    var assignment: DueAssignments?

    init(viewModel: AssignmentsViewModel) {
        self.viewModel = viewModel
        super.init(
            nibName: String(describing: InstructionsVC.self),
            bundle: Bundle(for: InstructionsVC.self)
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addInstructions()
    }
    
    @objc func addInstructions() {

        let (date, _) = AppDelegate.shared().getDueDate(assignment?.dueDate)
        let bullet = "•  "
        var strings = [String]()
        strings.append("Time: This assignment has a time of \(assignment?.examTime ?? 0) minutes")
        strings.append("Timer Settings: This assignment will save and automatically when the time expires.")
        strings.append("This assignment can be saved and resumed at any point until time has expired. The timer will continue to run if you leave the assignment.")
        strings.append("Due Date: This assignment due on \(date.replacingOccurrences(of: "00:00 AM", with: "12:00 AM"))")
        strings.append("Click Yes to start: \(assignment?.name ?? ""). Click No to go back.")
        strings = strings.map { return bullet + $0 }
        
        var attributes = [NSAttributedString.Key: Any]()
        attributes[.font] = UIFont.preferredFont(forTextStyle: .body)
        attributes[.foregroundColor] = UIColor.darkGray
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
        attributes[.paragraphStyle] = paragraphStyle

        let string = strings.joined(separator: "\n")
        mainLabel.attributedText = NSAttributedString(string: string, attributes: attributes)
    }
    
    @IBAction func noAction(_ sender: Any) {
        bottomSheetVC?.dismissViewController()
    }
    
    @IBAction func yesAction(_ sender: Any) {
        
        bottomSheetVC?.dismissViewController()
        
        let params = ["user_id": AppUserDefault.getUserId(),
                      "assignment_id": assignment?.id ?? -1,
                      "language":"en",
        ] as [String: Any]
        
        viewModel.getAssignmentQuestions(params: params, completion: {[weak self] in
            
            guard let _self = self else {return}
            
            guard (_self.viewModel.questionsModel) != nil,
            let controller = _self.superView else {return}
            
            let coordinator = AssignmentsCoordinator(controller: controller, viewModel: _self.viewModel, assignment: _self.assignment)
            coordinator.openController()
        })
    }
    
}
