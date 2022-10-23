//
//  ClassReviewsVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 22/10/22.
//

import UIKit
import SJSegmentedScrollView

class ClassReviewsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ratingCV: UICollectionView!
    @IBOutlet weak var reviewLabel: UILabel!

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
        
        let review = Float(classDetail?.get_user_review_avg_rating ?? "0") ?? 0
        reviewLabel.text = "\(String(format: "%.2f", review)) (\(classDetail?.total_reviews ?? 0) reviews)"
        
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
    
    @IBAction func onSeeAllButtonTap(_ sender: Any) {
        if classDetail?.reviews.count ?? 0>0 {
            if let viewC: AllReviewsVC = UIStoryboard(name: "Course", bundle: nil).instantiateViewController(withIdentifier: "AllReviewsVC") as? AllReviewsVC {
                viewC.classDetail = classDetail
                self.navigationController?.pushViewController(viewC, animated: true)
            }
        }
        
    }
    

}

extension ClassReviewsVC: SJSegmentedViewControllerViewSource {
    
    func viewForSegmentControllerToObserveContentOffsetChange() -> UIView {
        return tableView
    }
}

extension ClassReviewsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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


extension ClassReviewsVC: UITableViewDelegate, UITableViewDataSource {
    
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
