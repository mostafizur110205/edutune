//
//  QuestionFourTVC.swift
//  EduTune
//
//  Created by DH on 18/12/22.
//

import UIKit

class QuestionFourTVC: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        setupLayouts()
    }
    
    private func setUpViews(){
        backgroundColor = UIColor.orange
    }
    
    private func setupLayouts() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
