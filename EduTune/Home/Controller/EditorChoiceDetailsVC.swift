//
//  EditorChoiceDetailsVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 25/12/22.
//

import UIKit
import FittedSheets

class EditorChoiceDetailsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var allClasses = [Class]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
                
        tableView.delegate = self
        tableView.dataSource = self
                
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension EditorChoiceDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
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
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let params = ["class_id": allClasses[indexPath.row].id ?? -1]
        APIService.shared.getCourseDetails(params: params, completion: { clsDetail in
            if let viewC: ClassDetailsVC = UIStoryboard(name: "Course", bundle: nil).instantiateViewController(withIdentifier: "ClassDetailsVC") as? ClassDetailsVC {
                viewC.classDetail = clsDetail
                self.navigationController?.pushViewController(viewC, animated: true)
            }
        })
    }
    
}

extension EditorChoiceDetailsVC: ClassTVCellDelegate {
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
                    sheetController.allowPullingPastMaxHeight = false
                    sheetController.allowPullingPastMinHeight = false
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
                    sheetController.allowPullingPastMaxHeight = false
                    sheetController.allowPullingPastMinHeight = false
                    sheetController.gripColor = UIColor(white: 0.5, alpha: 1)
                    
                    self.present(sheetController, animated: true, completion: nil)
                }
            }

        }
    }
}

extension EditorChoiceDetailsVC: AddRemoveBookmarkVCDelegate {
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
