//
//  ClassDetailsVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 22/10/22.
//

import UIKit
import SJSegmentedScrollView
import UICollectionViewLeftAlignedLayout

class ClassDetailsVC: SJSegmentedViewController {

    @IBOutlet weak var enrolButton: UIButton!
    @IBOutlet weak var featureCV: UICollectionView!

    var selectedSegment: SJSegmentTab?
    var selectedSegmentIndex: Int = 0
    
    var classDetail: ClassDetail?
    var features = [Feature]()

    override func viewDidLoad() {
        guard let viewC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "ClassAboutVC") as? ClassAboutVC else {return}
        viewC.title = "About"
        viewC.classDetail = self.classDetail

        guard let viewC2 = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "ClassLessonsVC") as? ClassLessonsVC else {return}
        viewC2.title = "Lessons"
        viewC2.classDetail = self.classDetail

        guard let viewC3 = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "ClassReviewsVC") as? ClassReviewsVC else {return}
        viewC3.title = "Reviews"
        viewC3.classDetail = self.classDetail

        guard let headerVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "ClassHeaderVC") as? ClassHeaderVC else {return}
        headerVC.classDetail = self.classDetail

        headerViewController = headerVC
        segmentControllers = [viewC, viewC2, viewC3]
        
        let cvHeight = getCollectionViewHeight()
        let imageHeight = ScreenSize.SCREEN_WIDTH/1.5

        headerViewHeight = imageHeight+cvHeight+164
        segmentViewHeight = 40
        segmentShadow = .light()
        selectedSegmentViewHeight = 2
        selectedSegmentViewColor = UIColor.init(hex: "335EF7", alpha: 1)
        segmentTitleColor = UIColor.init(hex: "9E9E9E", alpha: 1)
        segmentTitleFont = UIFont.urbanist(style: .semiBold, ofSize: 18)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        headerViewOffsetHeight = (AppDelegate.shared().topInset)+44
        segmentBackgroundColor = .clear
        segmentedScrollViewColor = .white
        
        delegate = self
        
        super.viewDidLoad()
        
        self.view.bringSubviewToFront(enrolButton)
        self.enrolButton.setTitle("Enroll Course - ৳\(classDetail?.current_price ?? 0)", for: .normal)
    }
    
    func getCollectionViewHeight() -> CGFloat {
        
        featureCV.delegate = self
        featureCV.dataSource = self
        
        let layout = UICollectionViewLeftAlignedLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        featureCV.collectionViewLayout = layout
        
        features = classDetail?.get_features ?? []
        return featureCV.collectionViewLayout.collectionViewContentSize.height
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func onEnrolButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ClassDetailsVC: SJSegmentedViewControllerDelegate {
    
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

extension ClassDetailsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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

