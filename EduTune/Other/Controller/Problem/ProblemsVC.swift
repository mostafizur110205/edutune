//
//  ProblemsVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 30/10/22.
//

import UIKit

class ProblemsVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var problems = [Problem]()
    var problemType: ProblemType?

    var currentPage = 1
    var lastPage = 1
    var isAPICalling: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true

        tableView.delegate = self
        tableView.dataSource = self
        
        getProblems(page: currentPage)
        
    }
    
    func getProblems(page: Int) {
        if isAPICalling {
            return
        }
        let params = ["user_id": AppUserDefault.getUserId(), "mode": "get"] as [String: Any]
        
        isAPICalling = true
        APIService.shared.getProblems(page: page, params: params, completion: { problems, problemType, currentPage, lastPage in
            
            self.currentPage = currentPage
            self.lastPage = lastPage
            
            self.isAPICalling = false
            
            self.problemType = problemType

            if page == 1 {
                self.problems = problems
            } else {
                self.problems += problems
            }
            
            self.tableView.reloadData()
        })
    }
    
    @IBAction func onAddProblemButtonTap(_ sender: Any) {
        if let viewC: AddProblemVC = UIStoryboard(name: "Other", bundle: nil).instantiateViewController(withIdentifier: "AddProblemVC") as? AddProblemVC {
            self.navigationController?.pushViewController(viewC, animated: true)
        }
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ProblemsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return problems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ProblemTVCell") as? ProblemTVCell else {return UITableViewCell()}
        
        cell.problem = problems[indexPath.row]
        
        if indexPath.row == problems.count-1 && currentPage < lastPage {
            getProblems(page: currentPage + 1)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewC: ProblemDetailsVC = UIStoryboard(name: "Other", bundle: nil).instantiateViewController(withIdentifier: "ProblemDetailsVC") as? ProblemDetailsVC {
            viewC.problem = problems[indexPath.row]
            self.navigationController?.pushViewController(viewC, animated: true)
        }
    }
    
}
