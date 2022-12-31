//
//  QuestionNineTVC+CollectionView.swift
//  EduTune
//
//  Created by DH on 31/12/22.
//

import UIKit

extension QuestionNineTVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.answerImages.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerImageCVC", for: indexPath) as? AnswerImageCVC else {return UICollectionViewCell()}
        
        cell.imageModel = viewModel?.answerImages[indexPath.row]
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
