//
//  FilterVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 14/10/22.
//

import UIKit
import MultiSlider

protocol FilterVCDelegate {
    func didApplyButtonTap(_ category: Int?, minPrice: Int, maxPrice: Int, rating: Int?)
}

class FilterVC: UIViewController {
    
    @IBOutlet weak var categoryCV: UICollectionView!
    @IBOutlet weak var priceSliderView: MultiSlider!
    @IBOutlet weak var ratingCV: UICollectionView!
    
    var delegate: FilterVCDelegate?
    
    var programs = [Program]()
    var categories = [String]()
    var selectedProgram: Int? {
        didSet{
            if let program = self.programs.first(where: { $0.id == self.selectedProgram }) {
                categorySelected = program.program_name ?? "All"
            } else {
                categorySelected = "All"
            }
        }
    }
    var categorySelected: String = "All"
    
    var selectedRating: Int?
    var cvData = ["All", "5", "4", "3", "2", "1"]
    
    var minPrice: Int = 0
    var maxPrice: Int = 25000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categories = programs.map({ $0.program_name ?? "" }).unique()
        self.categories.insert("All", at: 0)
        
        categoryCV.delegate = self
        categoryCV.dataSource = self
        
        ratingCV.delegate = self
        ratingCV.dataSource = self
        
        self.priceSliderView.value = [CGFloat(minPrice), CGFloat(maxPrice)]
        self.priceSliderView.valueLabelPosition = .top
        self.priceSliderView.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        
    }
    
    @IBAction func onResetButtonTap(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.didApplyButtonTap(nil, minPrice: 0, maxPrice: 25000, rating: nil)
        }
    }
    
    @objc func sliderChanged(_ slider: MultiSlider) {
        print("thumb \(slider.draggedThumbIndex) moved")
        print("now thumbs are at \(slider.value)") // e.g., [1.0, 4.5, 5.0]
    }
    
    @IBAction func onApplyButtonTap(_ sender: Any) {
        self.dismiss(animated: true) {
            
            if let program = self.programs.first(where: { $0.program_name == self.categorySelected }) {
                self.delegate?.didApplyButtonTap(program.id, minPrice: Int(self.priceSliderView.value[0]), maxPrice: Int(self.priceSliderView.value[1]), rating: self.selectedRating)
            } else {
                self.delegate?.didApplyButtonTap(nil, minPrice: Int(self.priceSliderView.value[0]), maxPrice: Int(self.priceSliderView.value[1]), rating: self.selectedRating)
            }
        }
    }
    
}

extension FilterVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == categoryCV ? categories.count : cvData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCV {
            guard let cell: CategoryCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVCell", for: indexPath) as? CategoryCVCell else {return UICollectionViewCell()}
            let category = categories[indexPath.item]
            cell.configure(with: category, selected: categorySelected == category, height: 38)
            
            return cell
        } else {
            guard let cell: CategoryCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVCell", for: indexPath) as? CategoryCVCell else {return UICollectionViewCell()}
            let rating = cvData[indexPath.item]
            
            cell.configure(with: rating, selected: selectedRating == Int(cvData[indexPath.item]), height: 38)
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCV {
            var textWidth: CGFloat = 0.0
            let text = categories[indexPath.item]
            textWidth = text.widthWithConstrainedHeight(height: 38, font: UIFont.urbanist(style: .semiBold, ofSize: 16)) + 32
            return CGSize(width: textWidth, height: 38)
        } else {
            var textWidth: CGFloat = 0.0
            let text = cvData[indexPath.item]
            textWidth = text.widthWithConstrainedHeight(height: 38, font: UIFont.urbanist(style: .semiBold, ofSize: 16)) + 60
            return CGSize(width: textWidth, height: 38)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCV {
            categorySelected = categories[indexPath.item]
            categoryCV.reloadData()
        } else {
            selectedRating = Int(cvData[indexPath.item])
            ratingCV.reloadData()
        }
    }
    
}
