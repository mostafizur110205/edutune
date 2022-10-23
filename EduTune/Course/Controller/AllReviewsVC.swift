//
//  AllReviewsVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 23/10/22.
//

import UIKit

class AllReviewsVC: UIViewController {

    @IBOutlet weak var ratingCV: UICollectionView!
    @IBOutlet weak var tableView: UITableView!

    var classDetail: ClassDetail? 
    var allReviews = [Review]()
    
    var selectedRating = "All"

    var cvData = ["All", "5", "4", "3", "2", "1"]

    override func viewDidLoad() {
        super.viewDidLoad()

        ratingCV.delegate = self
        ratingCV.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        filterReviews()

    }
    
    func filterReviews(){
        
        if selectedRating == "All" {
            allReviews = classDetail?.reviews ?? []
        } else {
            allReviews = (classDetail?.reviews ?? []).filter({ $0.rating == Int(selectedRating) })
        }

        tableView.reloadData()
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension AllReviewsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cvData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: CategoryCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVCell", for: indexPath) as? CategoryCVCell else {return UICollectionViewCell()}
        let rating = cvData[indexPath.item]
        
        cell.configure(with: rating, selected: selectedRating == rating, height: 38)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var textWidth: CGFloat = 0.0
        let text = cvData[indexPath.item]
        textWidth = text.widthWithConstrainedHeight(height: 38, font: UIFont.urbanist(style: .semiBold, ofSize: 16)) + 60
        return CGSize(width: textWidth, height: 38)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedRating = cvData[indexPath.item]
        collectionView.reloadData()
        
        filterReviews()
    }
    
}


extension AllReviewsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allReviews.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ReviewTVCell") as? ReviewTVCell else {return UITableViewCell()}
        cell.review = allReviews[indexPath.row]
        return cell
    }
    
}
