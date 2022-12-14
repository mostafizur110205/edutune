//
//  QuestionHeaderView.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 17/12/22.
//

import UIKit

class QuestionHeaderView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
        setupLayout()
    }
 
   private func addSubViews(){
        backgroundColor = UIColor.white
        addSubview(titleLabel)
    }
    
    private func setupLayout() {
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant:-20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant:-20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



