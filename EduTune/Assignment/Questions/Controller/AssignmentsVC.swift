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
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressCountLabel: UILabel!
    
    var viewModel: AssignmentsViewModel?
    var questionCVCell: QuestionCVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
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
    
    func updateProgressBar(withValue value: Int) {
        
        guard let totalQuestion = viewModel?.questionsModel?.questionItems?.count else {return}
        let progress = (Float( 1.0) / Float(totalQuestion)) * Float(value + 1)
        progressBar.setProgress(progress, animated: true)
        progressCountLabel.text = "\(value + 1)" + "/" + "\(totalQuestion)"
    }
    
    private func setupViews() {
        
        reportButton.setTitle("", for: .normal)
        reportButton.setImage(UIImage(named: "ic_problem")?.withRenderingMode(.alwaysTemplate), for: .normal)
        reportButton.tintColor = UIColor.lightGray
        
        QuestionCVC.register(for: collectionView)
        
        let cellSize = CGSize(width: 0, height: 0)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.reloadData()
    }
    
}


