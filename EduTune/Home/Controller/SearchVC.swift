//
//  SearchVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 14/10/22.
//

import UIKit

class SearchVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchTextField: UITextField!
    
    var allClasses = [Class]()
    
    var currentPage = 1
    var lastPage = 1
    var isAPICalling: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchTextField.delegate = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        getSearchResult(text: "")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.searchTextField.becomeFirstResponder()
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onFilterButtonTap(_ sender: Any) {
        
    }
    
    func filterContentForSearchText(_ searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        currentPage = 1
        perform(#selector(getSearchResult), with: searchText, afterDelay: 0.5)
    }
    
    @objc func getSearchResult(text: String) {
        if isAPICalling {
            return
        }
        //rating, min_price, max_price, program_id
        var params: [String: Any] = ["type": "MOST_POPULAR_COURSES", "search_key": text, "min_price": 0, "max_price": 25000]
        
        isAPICalling = true
        APIService.shared.getMostPopular(page: currentPage, params: params, completion: { classes, programs, currentPage, lastPage in
            
            self.currentPage = currentPage
            self.lastPage = lastPage
            
            self.isAPICalling = false
            
            if currentPage == 1 {
                self.allClasses = classes
            } else {
                self.allClasses += classes
            }
            
            self.tableView.reloadData()
        })
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchTextField.resignFirstResponder()
    }
    
}

extension SearchVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            self.filterContentForSearchText(updatedText)
        }
        
        return true
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allClasses.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ClassTVCell") as? ClassTVCell else {return UITableViewCell()}
        
        let classData = allClasses[indexPath.row]
        cell.classData = classData
        
        if indexPath.row == allClasses.count-1 && currentPage < lastPage {
            currentPage += 1
            getSearchResult(text: searchTextField.text!)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
