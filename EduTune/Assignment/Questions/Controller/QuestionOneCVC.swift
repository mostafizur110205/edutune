//
//  QuestionOneCVC.swift
//  EduTune
//
//  Created by DH on 11/12/22.
//

import Foundation
import UIKit

class QuestionOneCVC: UICollectionViewCell {
    @IBOutlet weak var marksLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
}


extension UICollectionViewCell {

    static func register(for collectionView: UICollectionView)  {
        let cellName = String(describing: self)
        let cellIdentifier = cellName
        let cellNib = UINib(nibName: String(describing: self), bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: cellIdentifier)
    }
}
