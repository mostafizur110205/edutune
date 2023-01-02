//
//  BlogListVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 23/10/22.
//

import UIKit

class BlogListVC: UIViewController {

    @IBOutlet weak var categoryCV: UICollectionView!
    @IBOutlet weak var blogCV: UICollectionView!

    let cellWidth = (ScreenSize.SCREEN_WIDTH-16)/2

    var types = [BlogType]()
    var allBlogs = [Blog]()
    var categories = [String]()

    var categorySelected = "All"

    var currentPage = 1
    var lastPage = 1
    var isAPICalling: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryCV.delegate = self
        categoryCV.dataSource = self
        
        blogCV.delegate = self
        blogCV.dataSource = self

        getBlogs(page: currentPage)

    }
    
    func getBlogs(page: Int) {
        if isAPICalling {
            return
        }
        var params: [String: Any] = ["type": "list"]
        
        if let category = types.first(where: { $0.type_name == categorySelected }) {
            params["type_id"] = category.id
        }
        
        isAPICalling = true
        APIService.shared.getBlogs(page: page, params: params, completion: { blogs, types, currentPage, lastPage in
            
            self.currentPage = currentPage
            self.lastPage = lastPage
            
            self.isAPICalling = false
            
            self.types = types
            
            if page == 1 {
                self.allBlogs = blogs
            } else {
                self.allBlogs += blogs
            }
            
            self.categories = types.map({ $0.type_name ?? "" }).unique()
            self.categories.insert("All", at: 0)
            
            self.categoryCV.reloadData()
            self.blogCV.reloadData()
        })
    }
}

extension BlogListVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCV {
            return categories.count
        } else  {
            return allBlogs.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoryCV {
            guard let cell: CategoryCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVCell", for: indexPath) as? CategoryCVCell else {return UICollectionViewCell()}
            let category = categories[indexPath.item]
            cell.configure(with: category, selected: categorySelected == category, height: 38)
            return cell
        }else {
            guard let cell: BlogCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlogCVCell", for: indexPath) as? BlogCVCell else {return UICollectionViewCell()}
            cell.blog = allBlogs[indexPath.item]
            
            if indexPath.row == allBlogs.count-1 && currentPage < lastPage {
                getBlogs(page: currentPage+1)
            }
            
            return cell
        }
            
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == categoryCV {
            var textWidth: CGFloat = 0.0
            let text = categories[indexPath.item]
            textWidth = text.widthWithConstrainedHeight(height: 38, font: UIFont.urbanist(style: .semiBold, ofSize: 16)) + 32
            return CGSize(width: textWidth, height: 38)
        }else {
            return CGSize(width: cellWidth, height: cellWidth*1.3)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == categoryCV {
            categorySelected = categories[indexPath.item]
            categoryCV.reloadData()
          
            currentPage = 1
            getBlogs(page: currentPage)
            
        } else {
            DispatchQueue.main.async {
                if let viewC: BlogDetailsVC = UIStoryboard(name: "Blog", bundle: nil).instantiateViewController(withIdentifier: "BlogDetailsVC") as? BlogDetailsVC {
                    viewC.blog = self.allBlogs[indexPath.item]
                    self.navigationController?.pushViewController(viewC, animated: true)
                }
            }
            
        }
        
    }
    
}
