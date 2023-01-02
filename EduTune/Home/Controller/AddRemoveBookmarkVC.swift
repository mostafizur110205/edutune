//
//  AddRemoveBookmarkVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 30/10/22.
//

import UIKit

protocol AddRemoveBookmarkVCDelegate {
    func didAddButtonTap(_ classId: Int?)
    func didRemoveButtonTap(_ bookmarkId: Int?)
}

class AddRemoveBookmarkVC: UIViewController {
    
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var oldPriceLine: UIView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var reviewStackView: UIStackView!
    
    var classData: Class?
    
    var delegate: AddRemoveBookmarkVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        update()
    }
    
    func update() {
        if let classData = classData {
            cellImageView.sd_setImage(with: URL(string: classData.photo ?? "" ), placeholderImage: nil)
            categoryLabel.text = "  \(classData.program_name ?? "")  "
            titleLabel.text = classData.name
            priceLabel.text = AppDelegate.shared().formatPrice(classData.current_price)
            statusLabel.text = classData.mode == 1 ? "Batch" : "Recorded Class"
            
            if classData.original_price ?? 0 == 0 {
                oldPriceLabel.text = ""
                oldPriceLine.isHidden = true
            } else {
                oldPriceLabel.text = "৳\(classData.original_price ?? 0)"
                oldPriceLine.isHidden = false
            }
            
            let review = Float(classData.get_user_review_avg_rating ?? "0") ?? 0
            
            if review == 0 {
                reviewStackView.isHidden = true
            } else {
                reviewStackView.isHidden = false
                reviewLabel.text = String(format: "%.2f", review)
            }
            
        }
        
    }
    
    
    @IBAction func onCanceButtonTap(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onAddButtonTap(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.didAddButtonTap(self.classData?.id)
        }
    }
    
    @IBAction func onRemoveButtonTap(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.didRemoveButtonTap(self.classData?.class_book_mark_id) 
        }
    }
    
}
