//
//  ProblemDetailsVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 27/12/22.
//

import UIKit

class ProblemDetailsVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var problemImageView: UIImageView!

    var problem: Problem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true

        tableView.delegate = self
        tableView.dataSource = self
               
        if let image = problem?.image {
            problemImageView.borderWidth = 1
            problemImageView.sd_setImage(with: URL(string: image), placeholderImage: nil)
        } else {
            problemImageView.borderWidth = 0
        }

    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ProblemDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ProblemTVCell") as? ProblemTVCell else {return UITableViewCell()}
        
        cell.problem = problem
        
        return cell
        
    }
    
}
