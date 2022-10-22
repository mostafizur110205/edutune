//
//  ClassReviewsVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 22/10/22.
//

import UIKit
import SJSegmentedScrollView

class ClassReviewsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var classDetail: ClassDetail? 

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension ClassReviewsVC: SJSegmentedViewControllerViewSource {
    
    func viewForSegmentControllerToObserveContentOffsetChange() -> UIView {
        return tableView
    }
}
