//
//  CertificatesVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 25/12/22.
//

import UIKit

class CertificatesVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var exportButton: UIButton!

    var certificates = [Certificate]()
    
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getMyCertificates()
    }
    
    func getMyCertificates() {
        let params = ["user_id": AppUserDefault.getUserId(), "type": "list"] as [String: Any]
        APIService.shared.getMyCertificates(params: params, completion: { certificates in
            self.certificates = certificates
            self.collectionView.reloadData()
            
            if certificates.count>0 {
                self.exportButton.setTitle(self.certificates[self.currentIndex].certificate_message, for: .normal)
                self.exportButton.backgroundColor = UIColor(named: (self.certificates[self.currentIndex].certificate_status ?? 0) == 1 ? "Primary500" : "Grey500")
            }
            
        })
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSxportButtonTap(_ sender: Any) {
        if certificates[currentIndex].is_completed ?? 0 == 1 {
            let imgeUrl = certificates[currentIndex].certificate_content ?? ""
            let activityViewController = UIActivityViewController(activityItems: [ imgeUrl ], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }

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
                currentIndex = index
                self.exportButton.setTitle(certificates[index].certificate_message, for: .normal)
                self.exportButton.backgroundColor = UIColor(named: (certificates[index].certificate_status ?? 0) == 1 ? "Primary500" : "Grey500")
            }
        }
    }
    
    private func findCenterIndex() -> Int? {
        let width = ScreenSize.SCREEN_WIDTH
        let index = Int(collectionView.contentOffset.x/width)
        return index
    }
    
}

extension CertificatesVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return certificates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: MyCertificateCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCertificateCVCell", for: indexPath) as? MyCertificateCVCell else {return UICollectionViewCell()}
        cell.certificate = certificates[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}
