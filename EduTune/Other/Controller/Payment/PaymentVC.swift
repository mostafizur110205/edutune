//
//  PaymentVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 30/10/22.
//


import UIKit
import SJSegmentedScrollView
import UICollectionViewLeftAlignedLayout

class PaymentVC: SJSegmentedViewController {

    @IBOutlet weak var navView: UIView!

    var selectedSegment: SJSegmentTab?
    var selectedSegmentIndex: Int = 0
    
    var viewC: PaymentDueVC?
    var viewC2: PaymentPaidVC?

    override func viewDidLoad() {
        viewC = UIStoryboard(name: "Other", bundle: nil).instantiateViewController(withIdentifier: "PaymentDueVC") as? PaymentDueVC
        viewC?.title = "Due"

        viewC2 = UIStoryboard(name: "Other", bundle: nil).instantiateViewController(withIdentifier: "PaymentPaidVC") as? PaymentPaidVC
        viewC2?.title = "Paid"

        headerViewController = UIViewController()
        segmentControllers = [viewC! , viewC2!]

        headerViewHeight = AppDelegate.shared().topInset+44
        segmentViewHeight = 40
        segmentShadow = .light()
        selectedSegmentViewHeight = 2
        selectedSegmentViewColor = UIColor.init(hex: "335EF7", alpha: 1)
        segmentTitleColor = UIColor.init(hex: "9E9E9E", alpha: 1)
        segmentTitleFont = UIFont.urbanist(style: .semiBold, ofSize: 18)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        headerViewOffsetHeight = AppDelegate.shared().topInset+44
        segmentBackgroundColor = .clear
        segmentedScrollViewColor = .white
        
        delegate = self
        
        super.viewDidLoad()
        
        self.view.bringSubviewToFront(navView)
        
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension PaymentVC: SJSegmentedViewControllerDelegate {
    
    func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {
        if !segments.isEmpty {
            
            selectedSegment?.titleColor(UIColor.init(hex: "9E9E9E", alpha: 1))

            selectedSegment = segments[index]
            
            selectedSegment?.titleColor(UIColor.init(hex: "335EF7", alpha: 1))
            
            if index != selectedSegmentIndex {
                selectedSegmentIndex = index
            }
        }
    }
}
