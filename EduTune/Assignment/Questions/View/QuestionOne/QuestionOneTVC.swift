//
//  QuestionOneTVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 17/12/22.
//

import UIKit

class QuestionOneTVC: UITableViewCell {
    
    var questionOptions: QuestionOptionsModel? {
        didSet{
            guard let model = questionOptions else {return}
            titleLabel.text = model.optionTitle
            
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
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let radioImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage.init(systemName: "circle")
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    let backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        view.cornerRadius = 10
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        setupLayouts()
    }
    
    private func setUpViews(){
        
        addSubview(backView)
        backView.addSubview(radioImageView)
        backView.addSubview(titleLabel)
    }
    
    private func setupLayouts() {
        
        backView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        backView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        backView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        backView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        radioImageView.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 20).isActive = true
        radioImageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        radioImageView.widthAnchor.constraint(equalToConstant: 25) .isActive = true
        radioImageView.heightAnchor.constraint(equalTo: radioImageView.widthAnchor).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: radioImageView.rightAnchor, constant: 10).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: backView.rightAnchor, constant:-20).isActive = true
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
