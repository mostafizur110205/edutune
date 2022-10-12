//
//  IntroViewController.swift
//  BOOM SOCCER
//
//  Created by Mostafizur Rahman on 26/5/20.
//  Copyright © 2020 PEEMZ. All rights reserved.
//

import UIKit

class IntroVC: SocialLoginVC {
    
    @IBOutlet weak var pagecontrol : UIPageControl!
    @IBOutlet weak var bottomCns: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var dataTuto: [[String: String]] = [
        ["image": "tuto_1", "title": "We provide the best\nlearning courses &\ngreat mentors!".localized()],
        ["image": "tuto_1", "title": "Learn anytime and\nanywhere easily and\nconveniently".localized()],
        ["image": "tuto_1", "title": "Let's improve your\nskills together with\nElera right now!".localized()]
    ]
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomCns.constant = AppDelegate.shared()!.bottomInset > 0 ? 0 : 10
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    @IBAction func onGetStartedButtonTap(_ sender: Any) {
//        let vc : PhoneVC = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "PhoneVC") as! PhoneVC
//        self.navigationController?.pushViewController(vc, animated: true)
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
                self.pagecontrol.currentPage = index
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

        cell.titleLabel.text = tutoData["title"]
        cell.cellImageView.image = UIImage(named: tutoData["image"] ?? "")
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    
}

