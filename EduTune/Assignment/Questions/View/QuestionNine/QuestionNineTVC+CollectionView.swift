//
//  QuestionNineTVC+CollectionView.swift
//  EduTune
//
//  Created by DH on 31/12/22.
//

import UIKit

extension QuestionNineTVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let model = viewModel,
              let assignmentsFiles = model.questionsModel?.questionItems?[model.questionIndex].assignmentFiles
        else {return 0}
        
        return assignmentsFiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerImageCVC", for: indexPath) as? AnswerImageCVC,
              let model = viewModel,
              let assignmentsFiles = model.questionsModel?.questionItems?[model.questionIndex].assignmentFiles
        else {return UICollectionViewCell()}
        
        cell.viewController = viewController
        cell.imageModel = assignmentsFiles[indexPath.row]
        cell.countLabel.text = "\(indexPath.row + 1)"
        headerLabel.isHidden = false
   
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: (self.collectionView.frame.width - 40) / 3,
                          height: (self.collectionView.frame.width - 40) / 3)
        return size
    }
    
}
