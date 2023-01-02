//
//  FileNameTVC.swift
//  EduTune
//
//  Created by DH on 31/12/22.
//


import UIKit
import SwiftUI

class FileNameTVC: UITableViewCell {
    
    var imageModel: AnswerImageModel? {
        didSet{
            guard let model = imageModel else {return}
            
            uploadImageView.image = model.image
            titleLabel.text = model.fileName
            
            guard model.isUploaded else {
                deleteButton.isHidden = true
                indicator.startAnimating()
                viewController?.nextButton.isEnabled = false
                viewController?.nextButton.backgroundColor = .lightGray
                return
            }
            deleteButton.isHidden = false
            indicator.stopAnimating()
            viewController?.nextButton.isEnabled = true
            viewController?.nextButton.backgroundColor = UIColor(named: "Primary500")
        }
    }
    
    var viewController: AssignmentsVC?
    var viewModel: AssignmentsViewModel?
    
    lazy var uploadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.setBackgroundImage(UIImage(systemName: "trash.circle.fill"), for: .normal)
        button.tintColor = .red.withAlphaComponent(0.8)
        button.addTarget(self, action: #selector(selectFileAction), for: .touchUpInside)
        return button
    }()
    
    lazy var indicator: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .medium)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.hidesWhenStopped = true
        activityView.cornerRadius = 10
        activityView.color = .white
        activityView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        return activityView
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
        
        contentView.isUserInteractionEnabled = true
        setUpViews()
        setupLayouts()
    }
    
    private func setUpViews(){
        
        addSubview(backView)
        backView.addSubview(uploadImageView)
        backView.addSubview(titleLabel)
        backView.addSubview(deleteButton)
        backView.addSubview(indicator)
    }
    
    private func setupLayouts() {
        
        backView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        backView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        backView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        backView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        uploadImageView.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 15).isActive = true
        uploadImageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 15).isActive = true
        uploadImageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -15).isActive = true
        uploadImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        uploadImageView.widthAnchor.constraint(equalTo: uploadImageView.heightAnchor).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo:  uploadImageView.rightAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: deleteButton.leftAnchor, constant:-10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant:20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant:-20).isActive = true
        
        deleteButton.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -15).isActive = true
        deleteButton.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        indicator.leftAnchor.constraint(equalTo: deleteButton.leftAnchor, constant: 0).isActive = true
        indicator.topAnchor.constraint(equalTo: deleteButton.topAnchor, constant: 0).isActive = true
        indicator.rightAnchor.constraint(equalTo: deleteButton.rightAnchor, constant:0).isActive = true
        indicator.bottomAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 0).isActive = true
    }
    
    @objc private func selectFileAction() {
        guard let controller = viewController,
              let model = imageModel else {return}
        viewModel?.deleteFile(imageModel: model, controller: controller)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

