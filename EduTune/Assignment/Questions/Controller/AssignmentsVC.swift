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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        QuestionOneCVC.register(for: collectionView)
        QuestionTwoCVC.register(for: collectionView)
        QuestionThreeCVC.register(for: collectionView)
        QuestionFourCVC.register(for: collectionView)
        QuestionSevenCVC.register(for: collectionView)
        QuestionNineCVC.register(for: collectionView)
        QuestionElevenCVC.register(for: collectionView)

    }
    
    //-IBOutlets
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

extension AssignmentsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //Datasource Methods
      func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
      }
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
          return viewModel?.questionsModel?.questionItems?.count ?? 0
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
          guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionOneCVC", for: indexPath) as? QuestionOneCVC else {return UICollectionViewCell()}
          
          cell.marksLabel.text = "\(viewModel?.questionsModel?.questionItems?[indexPath.row].point ?? 0) Marks"
          cell.textView.attributedText = viewModel?.questionsModel?.questionItems?[indexPath.row].htmlTitle?.htmlToAttributedString
          
          return cell
      }
      
    
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
          return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
      }
}
