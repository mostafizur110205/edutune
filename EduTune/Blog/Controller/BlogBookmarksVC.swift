//
//  BlogBookmarksVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 23/10/22.
//

import UIKit

class BlogBookmarksVC: UIViewController {
   
    @IBOutlet weak var blogCV: UICollectionView!

    var allBlogs = [Blog]()
    let cellWidth = (ScreenSize.SCREEN_WIDTH-16)/2

    override func viewDidLoad() {
        super.viewDidLoad()

        blogCV.delegate = self
        blogCV.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getBlogs()

    }
    
    func getBlogs() {
        if AppDelegate.shared().checkAndShowLoginVC(navigationController: self.navigationController) {
            let params: [String: Any] = ["type": "bookmark_list", "user_id": AppUserDefault.getUserId()]
                    
            APIService.shared.getBlogBookmarks(params: params) { blogs in
                self.allBlogs = blogs
                self.blogCV.reloadData()

            }
        }
        
    }
}

extension BlogBookmarksVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allBlogs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: BlogCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlogCVCell", for: indexPath) as? BlogCVCell else {return UICollectionViewCell()}
        cell.blog = allBlogs[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellWidth*1.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewC: BlogDetailsVC = UIStoryboard(name: "Blog", bundle: nil).instantiateViewController(withIdentifier: "BlogDetailsVC") as? BlogDetailsVC {
            viewC.blog = allBlogs[indexPath.item]
            self.navigationController?.pushViewController(viewC, animated: true)
        }
        
    }
    
}
