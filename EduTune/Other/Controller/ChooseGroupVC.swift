//
//  ChooseGroupVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 27/12/22.
//

import UIKit

protocol ChooseGroupVCDelegate {
    func didChooseGroup(_ selectedClassId: Int?, selectedGroupId: Int?)
}

class ChooseGroupVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!

    var groupData = [UserGoal]()
    
    var selectedClassId: Int?
    var selectedGroupId: Int?
    var titleText: String = ""
    
    var delegate: ChooseGroupVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        titleLabel.text = "Select group of \(titleText)"
        
    }
    
    @IBAction func onCancelButtonTap(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onSaveButtonTap(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.didChooseGroup(self.selectedClassId, selectedGroupId: self.selectedGroupId)
        }
    }
    
}

extension ChooseGroupVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "MoreTVCell") as? MoreTVCell else {return UITableViewCell()}
        
        let cellData = groupData[indexPath.row]
        cell.iconImageView.sd_setImage(with: URL(string: cellData.icon ?? "" ), placeholderImage: nil)
        cell.titleLabel.text = cellData.name
        
        cell.radioIconImageView.image = UIImage(named: cellData.id == selectedGroupId ? "ic_radio_on" : "ic_radio_off")
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
                
        selectedGroupId = groupData[indexPath.row].id
        tableView.reloadData()
        
    }
    
}
