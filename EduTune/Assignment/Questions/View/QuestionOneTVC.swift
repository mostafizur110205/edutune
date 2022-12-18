//
//  QuestionOneTVC.swift
//  EduTune
//
//  Created by DH on 17/12/22.
//

import UIKit

class QuestionOneTVC: UITableViewCell {
    
    var questionOptions: QuestionOptionsModel? {
        didSet{
            guard let model = questionOptions else {return}
            titleLabel.text = model.optionTitle
            
            print("isselected - \(model.isSelected)")
            guard model.isSelected else {
                radioImageView.image = UIImage.init(systemName: "circle")
                return
            }
            radioImageView.image = UIImage.init(systemName: "circle.fill")
            layoutIfNeeded()
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let radioImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage.init(systemName: "circle")
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        setupLayouts()
    }
    
    private func setUpViews(){
        backgroundColor = UIColor.white
        
        addSubview(radioImageView)
        addSubview(titleLabel)
    }
    
    private func setupLayouts() {
        
        radioImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        radioImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        radioImageView.widthAnchor.constraint(equalToConstant: 25) .isActive = true
        radioImageView.heightAnchor.constraint(equalTo: radioImageView.widthAnchor).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: radioImageView.rightAnchor, constant: 10).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant:-20).isActive = true
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UITableViewCell {
    
    static func register(for tableView: UITableView)  {
        let cellName = String(describing: self)
        let cellIdentifier = cellName
        tableView.register(self, forCellReuseIdentifier: cellIdentifier)
    }
}
