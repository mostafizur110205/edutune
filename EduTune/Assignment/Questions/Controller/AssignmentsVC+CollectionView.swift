//
//  AssignmentsVC+CollectionView.swift
//  EduTune
//
//  Created by DH on 17/12/22.
//

import UIKit

extension AssignmentsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.questionsModel?.questionItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionCVC", for: indexPath) as? QuestionCVC else {return UICollectionViewCell()}

        cell.questionItem = viewModel?.questionsModel?.questionItems?[indexPath.row]
        
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        updateProgressBar(withValue: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        return size
    }
 
}

extension UICollectionView {
    
    func getVisibleCellIndex() -> Int {
        
        var visibleRect = CGRect()
        visibleRect.origin = self.contentOffset
        visibleRect.size = self.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = self.indexPathForItem(at: visiblePoint) else { return 0}
        return indexPath.row
    }
}
