//
//  AllCoursesVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 13/10/22.
//

import UIKit

class MostPopularCoursesVC: UIViewController {
    @IBOutlet weak var categoryCV: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var categories = [String]()
    var categorySelected = "All"
    var programs = [Program]()
    var allClasses = [Class]()
    
    var currentPage = 1
    var lastPage = 1
    var isAPICalling: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        
        categoryCV.delegate = self
        categoryCV.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getMostPopular(page: currentPage)
        
    }
    
    func getMostPopular(page: Int) {
        if isAPICalling {
            return
        }
        var params: [String: Any] = ["type": "MOST_POPULAR_COURSES"]
        
        if let program = programs.first(where: { $0.program_name == categorySelected }) {
            params["program_id"] = program.id
        }
        
        isAPICalling = true
        APIService.shared.getMostPopular(page: page, params: params, completion: { classes, programs, currentPage, lastPage in
            
            self.currentPage = currentPage
            self.lastPage = lastPage
            
            self.isAPICalling = false
            
            self.programs = programs
            
            if page == 1 {
                self.allClasses = classes
            } else {
                self.allClasses += classes
            }
            
            self.categories = programs.map({ $0.program_name ?? "" }).unique()
            self.categories.insert("All", at: 0)
            
            self.categoryCV.reloadData()
            self.tableView.reloadData()
        })
    }

    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSearchButtonTap(_ sender: Any) {
        
    }
    
}

extension MostPopularCoursesVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: CategoryCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVCell", for: indexPath) as? CategoryCVCell else {return UICollectionViewCell()}
        let category = categories[indexPath.item]
        cell.configure(with: category, selected: categorySelected == category, height: 38)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var textWidth: CGFloat = 0.0
        let text = categories[indexPath.item]
        textWidth = text.widthWithConstrainedHeight(height: 38, font: UIFont.urbanist(style: .semiBold, ofSize: 16)) + 32
        return CGSize(width: textWidth, height: 38)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        categorySelected = categories[indexPath.item]
        categoryCV.reloadData()
        
        currentPage = 1
        getMostPopular(page: currentPage)
    }
    
}


extension MostPopularCoursesVC: UITableViewDelegate, UITableViewDataSource {
    
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
            getMostPopular(page: currentPage + 1)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
