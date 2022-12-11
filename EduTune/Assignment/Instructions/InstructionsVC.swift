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

    init() {
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

        let bullet = "•  "
        var strings = [String]()
        strings.append("Time: This assignment has a time of 40 minutes")
        strings.append("Timer Settings: This assignment will save and automatically when the time expires.")
        strings.append("This assignment can be saved and resumed at any point until time has expired. The timer will continue to run if you leave the assignment.")
        strings.append("Due Date: This assignment due on Monday 5th of December 2022 11:59:00 PM")
        strings.append("Click Yes to start: Monthly Exam 01. Click No to go back.")
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
    }
    
}
