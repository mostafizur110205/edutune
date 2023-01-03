//
//  QuestionFourTVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 17/12/22.
//

import UIKit

class QuestionSevenTVC: UITableViewCell {
    
    var questionItem: QuestionItemModel? {
        didSet{
            guard let model = questionItem else {return}
            titleLabel.text = model.title
        }
    }
    var viewModel: AssignmentsViewModel?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        return textField
    }()
    
    let stackView: UIStackView = {
        let stackView   = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis  = .horizontal
        stackView.distribution  = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.white
        
        setUpViews()
        setupLayouts()
       
        textField.delegate = self
    }
    
    private func setUpViews(){
        
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(textField)
    }
    
    private func setupLayouts() {
        
        stackView.leftAnchor.constraint(lessThanOrEqualTo: leftAnchor, constant: 20).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant:-10).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QuestionSevenTVC: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let model = viewModel {
            model.questionsModel?.questionItems?[model.questionIndex].answer = textField.text ?? ""
        }
        return true
        
    }

}
