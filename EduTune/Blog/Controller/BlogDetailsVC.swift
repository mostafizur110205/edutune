//
//  BlogDetailsVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 23/10/22.
//

import UIKit

class BlogDetailsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var backButtonTopCns: NSLayoutConstraint!
    
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
        
    }
    
    @IBAction func onShareButtonTap(_ sender: Any) {
        
    }
    
    func refreshUI() {
        coverImageView.sd_setImage(with: URL(string: blog?.post_image ?? "" ), placeholderImage: nil)
        titleLabel.text = blog?.post_title
        categoryLabel.text = "  \(blog?.type?.type_name ?? "")  "
        
        let detailHeight = (blog?.post_title ?? "").heightOfLabel(font: UIFont.urbanist(style: .bold, ofSize: 24), width: (ScreenSize.SCREEN_WIDTH-133), numberOfLines: 0)
        
        tableView.tableHeaderView?.frame.size = CGSize(width: tableView.frame.width, height: CGFloat(detailHeight+345))
        
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
