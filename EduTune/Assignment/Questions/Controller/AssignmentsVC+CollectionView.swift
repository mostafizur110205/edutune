//
//  AssignmentsVC+CollectionView.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 17/12/22.
//

import UIKit

extension AssignmentsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let questionModel = viewModel?.questionsModel else {return 0}
        return questionModel.questionItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionCVC", for: indexPath) as? QuestionCVC else {return UICollectionViewCell()}

        cell.questionItem = viewModel?.questionsModel?.questionItems?[indexPath.row]
        cell.viewModel = viewModel
        cell.viewController = self
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        viewModel?.setCurrentQuestion(collectionViewCellIndex: indexPath.row)
        updateProgressBar(withValue: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        return size
    }
 
}

