//
//  BlogVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 23/10/22.
//


import UIKit
import SJSegmentedScrollView
import UICollectionViewLeftAlignedLayout

class BlogVC: SJSegmentedViewController {

    @IBOutlet weak var navView: UIView!

    var selectedSegment: SJSegmentTab?
    var selectedSegmentIndex: Int = 0
    
    var classDetail: ClassDetail?
    var features = [Feature]()

    override func viewDidLoad() {
        guard let viewC = UIStoryboard(name: "Blog", bundle: nil).instantiateViewController(withIdentifier: "BlogListVC") as? BlogListVC else {return}
        viewC.title = "All Blog"

        guard let viewC2 = UIStoryboard(name: "Blog", bundle: nil).instantiateViewController(withIdentifier: "BlogBookmarksVC") as? BlogBookmarksVC else {return}
        viewC2.title = "Bookmark"

        headerViewController = UIViewController()
        segmentControllers = [viewC, viewC2]

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}

extension BlogVC: SJSegmentedViewControllerDelegate {
    
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
