//
//  SelectFileHeaderView.swift
//  EduTune
//
//  Created by DH on 31/12/22.
//

import UIKit

class SelectFileHeaderView: UIView {
    
    var viewModel: AssignmentsViewModel?
    var viewController: AssignmentsVC?
    
    lazy var selectFileButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Select File", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.setTitleColor(.blue, for: .normal)
        button.borderColor = .blue
        button.addTarget(self, action: #selector(selectFileAction), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
        setupLayout()
    }
    
    private func addSubViews(){
        backgroundColor = .white
        addSubview(selectFileButton)
    }
    
    private func setupLayout() {
        
        selectFileButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        selectFileButton.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        selectFileButton.rightAnchor.constraint(equalTo: rightAnchor, constant:-20).isActive = true
        selectFileButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant:-20).isActive = true
    }
    
    @objc private func selectFileAction() {
        guard let controller = viewController else {return}
        viewModel?.currentQuestionType = .essay
        viewModel?.showPhotoPromptActionSheet(controller: controller)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
