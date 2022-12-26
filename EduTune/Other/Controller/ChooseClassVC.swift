//
//  ChooseClassVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 27/12/22.
//

import UIKit
import FittedSheets

class ChooseClassVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var classData = [UserGoal]()
    
    var selectedClassId: Int?
    var selectedGroupId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSaveButtonTap(_ sender: Any) {
        setUserGoals()
    }
    
    func setUserGoals() {
        var params = ["user_id": AppUserDefault.getUserId(), "type": "set", "goal_class_id": selectedClassId ?? -1] as [String: Any]
        
        if let groupId = selectedGroupId {
            params["goal_group_id"] = selectedGroupId
        }
        
        APIService.shared.getSetUserGoals(params: params, completion: { syllabus in
            self.navigationController?.popViewController(animated: true)
        })
    }
    
}

extension ChooseClassVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "MoreTVCell") as? MoreTVCell else {return UITableViewCell()}
        
        let cellData = classData[indexPath.row]
        cell.iconImageView.sd_setImage(with: URL(string: cellData.icon ?? "" ), placeholderImage: nil)
        cell.titleLabel.text = cellData.name
        
        cell.radioIconImageView.image = UIImage(named: cellData.id == selectedClassId ? "ic_radio_on" : "ic_radio_off")
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cellData = classData[indexPath.row]
        
        if cellData.group.count>0 {
            if let viewC: ChooseGroupVC = UIStoryboard(name: "Other", bundle: nil).instantiateViewController(withIdentifier: "ChooseGroupVC") as? ChooseGroupVC {
                viewC.delegate = self
                viewC.groupData = cellData.group
                viewC.selectedClassId = cellData.id
                viewC.selectedGroupId = self.selectedGroupId
                viewC.titleText = cellData.name ?? ""
                let options = SheetOptions (
                    shrinkPresentingViewController: false
                )
                let sheetController = SheetViewController(controller: viewC, sizes: [.fixed(CGFloat(160+(cellData.group.count*70)))], options: options)
                sheetController.didDismiss = { _ in
                    print("Sheet dismissed")
                    
                }
                sheetController.allowPullingPastMaxHeight = false
                sheetController.allowPullingPastMinHeight = false
                sheetController.gripColor = UIColor(white: 0.5, alpha: 1)
                
                self.present(sheetController, animated: true, completion: nil)
            }
        } else {
            selectedClassId = cellData.id
            selectedGroupId = nil
            tableView.reloadData()
        }
        
    }
    
}

extension ChooseClassVC: ChooseGroupVCDelegate {
    func didChooseGroup(_ selectedClassId: Int?, selectedGroupId: Int?) {
        self.selectedClassId = selectedClassId
        self.selectedGroupId = selectedGroupId
        tableView.reloadData()
    }
}
