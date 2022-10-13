//
//  IntroViewController.swift
//  BOOM SOCCER
//
//  Created by Mostafizur Rahman on 26/5/20.
//  Copyright © 2020 PEEMZ. All rights reserved.
//

import UIKit
import SDWebImage

class IntroVC: SocialLoginVC {
    
    @IBOutlet weak var pagecontrol : UIPageControl!
    @IBOutlet weak var bottomCns: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!

    var dataTuto: [OnboardData] = [OnboardData]()
    
    var currentIndex = 0
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomCns.constant = AppDelegate.shared().bottomInset > 0 ? 0 : 10
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    @IBAction func onGetStartedButtonTap(_ sender: Any) {
        if currentIndex == 2 {
            if let viewC: TabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC {
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = viewC
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.makeKeyAndVisible()
            }
        } else {
            currentIndex += 1
            self.collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
            self.pagecontrol.currentPage = currentIndex
            self.nextButton.setTitle(currentIndex==2 ? "Get started" : "Next", for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollingFinished(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollingFinished(scrollView)
        }
    }
    
    func scrollingFinished(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            
            if let index = findCenterIndex(){
                self.currentIndex = index
                self.pagecontrol.currentPage = index
                self.nextButton.setTitle(index==2 ? "Get started" : "Next", for: .normal)
            }
        }
    }
    
    private func findCenterIndex() -> Int? {
        let width = ScreenSize.SCREEN_WIDTH
        let index = Int(collectionView.contentOffset.x/width)
        return index
    }
    
}

extension IntroVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataTuto.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: IntroCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntroCVCell", for: indexPath) as! IntroCVCell
        
        let tutoData = dataTuto[indexPath.item]

        cell.titleLabel.text = tutoData.splash_name
        cell.cellImageView.sd_setImage(with: URL(string: tutoData.image ?? "" ), placeholderImage: nil)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    
}

