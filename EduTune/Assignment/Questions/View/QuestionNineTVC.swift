//
//  QuestionNineTVC.swift
//  EduTune
//
//  Created by DH on 18/12/22.
//

import UIKit

class QuestionNineTVC: UITableViewCell {
    
    var viewModel: AssignmentsViewModel?
    var viewController: AssignmentsVC?
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Answer:"
        label.isHidden = true
        return label
    }()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.showsVerticalScrollIndicator = false
        view.isScrollEnabled = true
        
        return view
    }()
    
    lazy var cameraButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.setBackgroundImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.addTarget(self, action: #selector(cameraAction), for: .touchUpInside)
        return button
    }()
    lazy var galleryButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.setBackgroundImage(UIImage(systemName: "photo.fill"), for: .normal)
        button.addTarget(self, action: #selector(galleryAction), for: .touchUpInside)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.white
        AnswerImageCVC.register(for: collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.delaysContentTouches = false
        
        setUpViews()
        setupLayouts()
    }
    
    private func setUpViews(){
        
        addSubview(headerLabel)
        contentView.addSubview(collectionView)
        addSubview(cameraButton)
        addSubview(galleryButton)
        
        collectionView.reloadData()
    }
    
    private func setupLayouts() {
        
        headerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        headerLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        cameraButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        cameraButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        cameraButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        cameraButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        galleryButton.leftAnchor.constraint(equalTo: cameraButton.rightAnchor, constant: 15).isActive = true
        galleryButton.centerYAnchor.constraint(equalTo: cameraButton.centerYAnchor).isActive = true
        galleryButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        galleryButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        collectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: cameraButton.topAnchor, constant: -20).isActive = true
    }
    
    @objc private func cameraAction() {
        guard let controller = viewController else {return}
        controller.deleagte = self
        viewModel?.openCamera(controller: controller)
    }
    
    @objc private func galleryAction() {
        guard let controller = viewController else {return}
        controller.deleagte = self
        viewModel?.openPhotoGallery(controller: controller)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension QuestionNineTVC: AssignmentsDelegate {
   
    func updateUploadedImages() {
        collectionView.reloadData()
    }
}
