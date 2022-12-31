//
//  AnswerImageCVC.swift
//  EduTune
//
//  Created by DH on 30/12/22.
//

import Foundation
import UIKit


class AnswerImageCVC: UICollectionViewCell {
    
    var imageModel: AnswerImageModel? {
        didSet{
            guard let model = imageModel else {return}
            imageView.image = model.image
            
            guard model.isUploaded else {
                countLabel.isHidden = true
                indicator.startAnimating()
                return
            }
            countLabel.isHidden = false
            indicator.stopAnimating()
        }
    }

    let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .center
        label.cornerRadius = 15
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        return imageView
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


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false

        setUpViews()
        setupLayouts()
    }
    
    private func setUpViews(){
    
        addSubview(imageView)
        addSubview(countLabel)
        addSubview(indicator)
    }
    
    private func setupLayouts() {
        
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor, constant:0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        indicator.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 0).isActive = true
        indicator.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 0).isActive = true
        indicator.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant:0).isActive = true
        indicator.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
        
        countLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        countLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        countLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        countLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
