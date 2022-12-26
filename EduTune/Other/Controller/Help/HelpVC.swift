//
//  HelpVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 30/10/22.
//

import UIKit
import SJSegmentedScrollView
import UICollectionViewLeftAlignedLayout

class HelpVC: SJSegmentedViewController {

    @IBOutlet weak var navView: UIView!

    var selectedSegment: SJSegmentTab?
    var selectedSegmentIndex: Int = 0
    
    var helpData: Help?
    var viewC: HelpFaqVC?
    var viewC2: HelpLinksVC?

    override func viewDidLoad() {
        viewC = UIStoryboard(name: "Other", bundle: nil).instantiateViewController(withIdentifier: "HelpFaqVC") as? HelpFaqVC
        viewC?.title = "FAQ"

        viewC2 = UIStoryboard(name: "Other", bundle: nil).instantiateViewController(withIdentifier: "HelpLinksVC") as? HelpLinksVC
        viewC2?.title = "Contact us"

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
        
        getHelpData()
    }
    
    func getHelpData() {
        APIService.shared.getHelpData { help in
            self.helpData = help
            self.viewC?.helpData = help
            self.viewC2?.helpData = help
        }
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension HelpVC: SJSegmentedViewControllerDelegate {
    
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
