//
//  AssignmentsVC.swift
//  EduTune
//
//  Created by DH on 11/12/22.
//

import Foundation
import UIKit


class AssignmentsVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: AssignmentsViewModel?
    var questionCVCell: QuestionCVC?
    var collectionViewIndexpath = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        QuestionCVC.register(for: collectionView)
        
        let cellSize = CGSize(width: 0, height: 0)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.reloadData()
    }
    
    @IBAction func onReportQuestion(_ sender: Any) {
    }
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onNextAction(_ sender: Any) {
        
        let cellSize = CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        let contentOffset = collectionView.contentOffset
        
        collectionView.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width + 10, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true);
    }
    
}


