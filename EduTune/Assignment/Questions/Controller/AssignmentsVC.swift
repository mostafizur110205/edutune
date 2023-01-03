//
//  AssignmentsVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 11/12/22.
//

import Foundation
import UIKit
import SVProgressHUD

protocol AssignmentsDelegate: AnyObject {
    func updateUploadedImages()
}

class AssignmentsVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var progressCountLabel: UILabel!
    
    var viewModel: AssignmentsViewModel?
    var questionCVCell: QuestionCVC?
    weak var deleagte: AssignmentsDelegate?
    var assignment: DueAssignments?

    var totalSecond = 0
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalSecond = (assignment?.examTime ?? 0)*60
        startTimer()
        setupViews()
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    @objc func countdown() {
        
        var minutes: Int
        var seconds: Int
        
        if totalSecond == 0 {
            timer?.invalidate()
            submitAssignment()
            timerLabel.text = ""
        }
        totalSecond = totalSecond - 1
        minutes = (totalSecond % 3600) / 60
        seconds = (totalSecond % 3600) % 60
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    @IBAction func onReportQuestion(_ sender: Any) {
        
    }
    
    @IBAction func onBack(_ sender: Any) {
        
        let alert = UIAlertController(title: "Confirmation", message: "Do you really want to exit from quiz?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "CONFIRM", style: .default, handler: { (action: UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (action: UIAlertAction!) in
            alert.dismiss(animated: true)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onNextAction(_ sender: Any) {
        
        let cellSize = CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        let contentOffset = collectionView.contentOffset
        
        collectionView.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width + 10, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
        
        if Int(contentOffset.x) == (Int(cellSize.width) + 10) * (viewModel?.questionsModel?.questionItems?.count ?? 0) {
            // last indexpath of collectionview
        }
        
        if nextButton.titleLabel?.text == "Submit" {
            
            let alert = UIAlertController(title: "Confirmation", message: "Do you really want to submit your answer?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "CONFIRM", style: .default, handler: {[weak self] (action: UIAlertAction!) in
                self?.submitAssignment()
            }))
            alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (action: UIAlertAction!) in
                alert.dismiss(animated: true)
            }))
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    private func submitAssignment() {
        
        SVProgressHUD.show()
        viewModel?.submitAssignment {
            SVProgressHUD.dismiss()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func updateProgressBar(withValue value: Int) {
        
        guard let totalQuestion = viewModel?.questionsModel?.questionItems?.count else {return}
        let progress = (Float( 1.0) / Float(totalQuestion)) * Float(value + 1)
        progressBar.setProgress(progress, animated: true)
        progressCountLabel.text = "\(value + 1)" + "/" + "\(totalQuestion)"
        
        guard totalQuestion == value + 1 else {return}
        nextButton.setTitle("Submit", for: .normal)
    }
    
    private func setupViews() {
        
        reportButton.setTitle("", for: .normal)
        reportButton.setImage(UIImage(named: "ic_problem")?.withRenderingMode(.alwaysTemplate), for: .normal)
        reportButton.tintColor = UIColor.darkGray
        
        QuestionCVC.register(for: collectionView)
        
        let cellSize = CGSize(width: 0, height: 0)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.reloadData()
    }
}








