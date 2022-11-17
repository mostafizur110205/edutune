//
//  SearchVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 14/10/22.
//

import UIKit
import FittedSheets

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
        cell.delegate = self
        cell.bookmarkButton.setImage(UIImage(named: AppDelegate.shared().bookmarkIds.contains(classData.class_book_mark_id ?? -1) ? "ic_bookmarked" : "ic_bookmark"), for: .normal)

        if indexPath.row == allClasses.count-1 && currentPage < lastPage {
            currentPage += 1
            getSearchResult(text: searchTextField.text!)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension SearchVC: ClassTVCellDelegate {
    func didBookmarkButtonTap(_ cell: ClassTVCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let classData = allClasses[indexPath.row]
            if AppDelegate.shared().bookmarkIds.firstIndex(where: { $0 == classData.class_book_mark_id }) != nil {
                if let viewC: AddRemoveBookmarkVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "RemoveBookmarkVC") as? AddRemoveBookmarkVC {
                    viewC.delegate = self
                    viewC.classData = classData
                    let options = SheetOptions (
                        shrinkPresentingViewController: false
                    )
                    let sheetController = SheetViewController(controller: viewC, sizes: [.fixed(340)], options: options)
                    sheetController.didDismiss = { _ in
                        print("Sheet dismissed")
                        
                    }
                    sheetController.gripColor = UIColor(white: 0.5, alpha: 1)
                    
                    self.present(sheetController, animated: true, completion: nil)
                }
            } else {
                if let viewC: AddRemoveBookmarkVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "AddBookmarkVC") as? AddRemoveBookmarkVC {
                    viewC.delegate = self
                    viewC.classData = classData
                    let options = SheetOptions (
                        shrinkPresentingViewController: false
                    )
                    let sheetController = SheetViewController(controller: viewC, sizes: [.fixed(340)], options: options)
                    sheetController.didDismiss = { _ in
                        print("Sheet dismissed")
                        
                    }
                    sheetController.gripColor = UIColor(white: 0.5, alpha: 1)
                    
                    self.present(sheetController, animated: true, completion: nil)
                }
            }

        }
    }
}

extension SearchVC: AddRemoveBookmarkVCDelegate {
    func didAddButtonTap(_ classId: Int?) {
        let params = ["class_id": classId ?? -1, "user_id": AppUserDefault.getUserId(), "type": "set"] as [String: Any]
        APIService.shared.addBookmark(params: params) { bookmark_id in
            AppDelegate.shared().bookmarkIds.append(bookmark_id)
            if let index = self.allClasses.firstIndex(where: { $0.id == classId }) {
                let classData = self.allClasses[index]
                classData.class_book_mark_id = bookmark_id
                self.allClasses[index] = classData
            }
            self.tableView.reloadData()
        }
    }
    
    func didRemoveButtonTap(_ bookmarkId: Int?) {
        let params = ["book_mark_id": bookmarkId ?? -1, "user_id": AppUserDefault.getUserId(), "type": "remove"] as [String: Any]
        
        APIService.shared.removeBookmark(params: params) { success in
            if let index = AppDelegate.shared().bookmarkIds.firstIndex(where: { $0 == bookmarkId }) {
                AppDelegate.shared().bookmarkIds.remove(at: index)
                self.tableView.reloadData()
            }
        }
    }
    
}
