//
//  QuestionNineTVC.swift
//  EduTune
//
//  Created by DH on 18/12/22.
//

import UIKit

class QuestionNineTVC: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        setupLayouts()
    }
    
    private func setUpViews(){
        backgroundColor = UIColor.purple
    }
    
    private func setupLayouts() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
