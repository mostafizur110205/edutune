//
//  QuestionCVC+cellHeight.swift
//  EduTune
//
//  Created by DH on 19/12/22.
//

import UIKit

extension QuestionCVC: UpdateCellHeightProtocol {
    
    func updateHeightOfRow(_ cell: QuestionElevenTVC, _ textView: UITextView) {
        
        let size = textView.bounds.size
        let newSize = tableView.sizeThatFits(CGSize(width: size.width,
                                                    height: CGFloat.greatestFiniteMagnitude))
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            tableView.beginUpdates()
            tableView.endUpdates()
            UIView.setAnimationsEnabled(true)
            if let thisIndexPath = tableView.indexPath(for: cell) {
                tableView.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
            }
        }
    }
}
