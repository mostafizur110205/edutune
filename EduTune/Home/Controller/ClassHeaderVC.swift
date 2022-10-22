//
//  ClassHeaderVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 22/10/22.
//

import UIKit
import UICollectionViewLeftAlignedLayout

class ClassHeaderVC: UIViewController {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var oldPriceLine: UIView!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var featureCV: UICollectionView!

    var classDetail: ClassDetail? 
    
    var features = [Feature]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewLeftAlignedLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        featureCV.collectionViewLayout = layout
        
        featureCV.delegate = self
        featureCV.dataSource = self
        
        refreshUI()

    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func refreshUI() {
        coverImageView.sd_setImage(with: URL(string: classDetail?.photo ?? "" ), placeholderImage: nil)
        titleLabel.text = classDetail?.name
        categoryLabel.text = "  \(classDetail?.program_name ?? "")  "
        
        let review = Float(classDetail?.get_user_review_avg_rating ?? "0") ?? 0
        
        if review == 0 {
            starImageView.isHidden = true
            ratingLabel.isHidden = true
        } else {
            starImageView.isHidden = false
            ratingLabel.isHidden = false
            ratingLabel.text = "\(String(format: "%.2f", review)) (\(classDetail?.total_reviews ?? 0) reviews)"
        }
        
        priceLabel.text = "৳\(classDetail?.current_price ?? 0)"

        if classDetail?.original_price ?? 0 == 0 {
            oldPriceLabel.text = ""
            oldPriceLine.isHidden = true
        } else {
            oldPriceLabel.text = "৳\(classDetail?.original_price ?? 0)"
            oldPriceLine.isHidden = false
        }
        
        features = classDetail?.get_features ?? []
        featureCV.reloadData()
    }

    @IBAction func onBookmarkButtonTap(_ sender: Any) {
   
    }
    
}

extension ClassHeaderVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return features.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CategoryCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVCell", for: indexPath) as? CategoryCVCell else {return UICollectionViewCell()}
        let category = (features[indexPath.item].name ?? "") + ": " + (features[indexPath.item].value ?? "")
        cell.tagNameLabel.text = category
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var textWidth: CGFloat = 0.0
        let text = (features[indexPath.item].name ?? "") + ": " + (features[indexPath.item].value ?? "")
        textWidth = text.widthWithConstrainedHeight(height: 26, font: UIFont.urbanist(style: .medium, ofSize: 16)) + 38
        return CGSize(width: textWidth, height: 26)
    }
    
}

