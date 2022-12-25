//
//  HelpFaqVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 25/12/22.
//

import UIKit
import ExpyTableView

class HelpFaqVC: UIViewController{
    
    @IBOutlet var tableView: ExpyTableView!
    
    var FAQQuestions: [String] = [String]()
    var FAQAnswers: [String] = [String]()
    
    var helpData: Help? {
        didSet {
            FAQQuestions = (helpData?.faqs ?? []).map({ $0.title ?? "" })
            FAQAnswers = (helpData?.faqs ?? []).map({ $0.description ?? "" })
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        tableView.expandingAnimation = .fade
        tableView.collapsingAnimation = .fade
        
        tableView.tableFooterView = UIView()
        
    }
    
    @objc private func orientationDidChange() {
        switch UIDevice.current.orientation {
        case .portrait, .portraitUpsideDown, .landscapeLeft, .landscapeRight:
            tableView.reloadSections(IndexSet(Array(tableView.expandedSections.keys)), with: .none)
        default:break
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = ""
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func onCloseButtonTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension HelpFaqVC: ExpyTableViewDataSource {
    
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        return true
    }
    
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QuestionTVCell.self)) as! QuestionTVCell
        cell.labelPhoneName.text = FAQQuestions[section]
        cell.layoutMargins = UIEdgeInsets.zero
        cell.showSeparator()
        return cell
    }
}

//MARK: ExpyTableView delegate methods
extension HelpFaqVC: ExpyTableViewDelegate {
    func tableView(_ tableView: ExpyTableView, expyState state: ExpyState, changeForSection section: Int) {
        
        switch state {
        case .willExpand:
            print("WILL EXPAND")
            
        case .willCollapse:
            print("WILL COLLAPSE")
            
        case .didExpand:
            print("DID EXPAND")
            
        case .didCollapse:
            print("DID COLLAPSE")
        }
    }
}

extension HelpFaqVC {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
}

extension HelpFaqVC {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //If you don't deselect the row here, seperator of the above cell of the selected cell disappears.
        //Check here for detail: https://stackoverflow.com/questions/18924589/uitableviewcell-separator-disappearing-in-ios7
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        //This solution obviously has side effects, you can implement your own solution from the given link.
        //This is not a bug of ExpyTableView hence, I think, you should solve it with the proper way for your implementation.
        //If you have a generic solution for this, please submit a pull request or open an issue.
        
        print("DID SELECT row: \(indexPath.row), section: \(indexPath.section)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: UITableView Data Source Methods
extension HelpFaqVC {
    func numberOfSections(in tableView: UITableView) -> Int {
        return  FAQQuestions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Please see https://github.com/okhanokbay/ExpyTableView/issues/12
        // The cell instance that you return from expandableCellForSection: data source method is actually the first row of belonged section. Thus, when you return 4 from numberOfRowsInSection data source method, first row refers to expandable cell and the other 3 rows refer to other rows in this section.
        // So, always return the total row count you want to see in that section
        
        return 2//FAQQuestions[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AnswerTVCell.self)) as! AnswerTVCell
        cell.labelSpecification.text = FAQAnswers[indexPath.section]
        cell.layoutMargins = UIEdgeInsets.zero
        cell.hideSeparator()
        return cell
    }
}
