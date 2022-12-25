//
//  BlogDetailsVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 23/10/22.
//

import UIKit
import FittedSheets

class BlogDetailsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var backButtonTopCns: NSLayoutConstraint!
    @IBOutlet weak var bookMarkButton: UIButton!
    
    var blog: Blog?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        backButtonTopCns.constant = AppDelegate.shared().topInset
        
        refreshUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onBookmarkButtonTap(_ sender: Any) {
        if blog?.book_mark_id != nil {
            if let viewC: AddRemoveBookmarkVC = UIStoryboard(name: "Blog", bundle: nil).instantiateViewController(withIdentifier: "RemoveBookmarkVC") as? AddRemoveBookmarkVC {
                viewC.delegate = self
                let options = SheetOptions (
                    shrinkPresentingViewController: false
                )
                let sheetController = SheetViewController(controller: viewC, sizes: [.fixed(180)], options: options)
                sheetController.didDismiss = { _ in
                    print("Sheet dismissed")
                    
                }
                sheetController.allowPullingPastMaxHeight = false
                sheetController.allowPullingPastMinHeight = false
                sheetController.gripColor = UIColor(white: 0.5, alpha: 1)
                
                self.present(sheetController, animated: true, completion: nil)
            }
        } else {
            if let viewC: AddRemoveBookmarkVC = UIStoryboard(name: "Blog", bundle: nil).instantiateViewController(withIdentifier: "AddBookmarkVC") as? AddRemoveBookmarkVC {
                viewC.delegate = self
                let options = SheetOptions (
                    shrinkPresentingViewController: false
                )
                let sheetController = SheetViewController(controller: viewC, sizes: [.fixed(180)], options: options)
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
    
    @IBAction func onShareButtonTap(_ sender: Any) {
        
    }
    
    func refreshUI() {
        coverImageView.sd_setImage(with: URL(string: blog?.post_image ?? "" ), placeholderImage: nil)
        titleLabel.text = blog?.post_title
        categoryLabel.text = "  \(blog?.type?.type_name ?? "")  "
        
        let detailHeight = (blog?.post_title ?? "").heightOfLabel(font: UIFont.urbanist(style: .bold, ofSize: 24), width: (ScreenSize.SCREEN_WIDTH-133), numberOfLines: 0)
        
        tableView.tableHeaderView?.frame.size = CGSize(width: tableView.frame.width, height: CGFloat(detailHeight+345))
        
        bookMarkButton.setImage(UIImage(named: blog?.book_mark_id == nil ? "ic_bookmark" : "ic_bookmarked"), for: .normal)
        
    }
    
}


extension BlogDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
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
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ClassAboutTVCell") as? ClassAboutTVCell else {return UITableViewCell()}
        
        cell.aboutLabel.attributedText = blog?.post_content?.htmlToAttributedString
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


extension BlogDetailsVC: AddRemoveBookmarkVCDelegate {
    func didRemoveButtonTap(_ bookmarkId: Int?) {
        let params = ["blog_user_bookmark_id": blog?.book_mark_id ?? -1, "user_id": AppUserDefault.getUserId(), "type": "remove_bookmark"] as [String: Any]
        
        APIService.shared.removeBlogBookmark(params: params) { success in
            self.blog?.book_mark_id = nil
            self.bookMarkButton.setImage(UIImage(named: "ic_bookmark"), for: .normal)
        }
    }
    
    func didAddButtonTap(_ classId: Int?) {
        let params = ["blog_id": blog?.id ?? -1, "user_id": AppUserDefault.getUserId(), "type": "set_bookmark"] as [String: Any]
        APIService.shared.addBlogBookmark(params: params) { bookmark_id in
            self.blog?.book_mark_id = bookmark_id
            self.bookMarkButton.setImage(UIImage(named: "ic_bookmarked"), for: .normal)
        }
    }
    
    
}
