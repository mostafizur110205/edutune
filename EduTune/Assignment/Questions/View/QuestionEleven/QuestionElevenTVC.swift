//
//  QuestionElevenTVC.swift
//  EduTune
//
//  Created by DH on 18/12/22.
//

import UIKit

protocol UpdateCellHeightProtocol: AnyObject {
    func updateHeightOfRow(_ cell: QuestionElevenTVC, _ textView: UITextView)
}

class QuestionElevenTVC: UITableViewCell {
    
    let textView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.font = UIFont.systemFont(ofSize: 15)
        view.keyboardType = .default
        view.returnKeyType = .default
        view.sizeToFit()
        view.isScrollEnabled = false
        view.isEditable = true
        return view
    }()
    
    var viewModel: AssignmentsViewModel?
    weak var delegate: UpdateCellHeightProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        textView.delegate = self        
        setUpViews()
        setupLayouts()
    }
    
    private func setUpViews(){
        addSubview(textView)
    }
    
    private func setupLayouts() {
        textView.leftAnchor.constraint(lessThanOrEqualTo: leftAnchor, constant: 20).isActive = true
        textView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        textView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant:-10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QuestionElevenTVC: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        
        if let model = viewModel {
            model.questionsModel?.questionItems?[model.questionIndex].answer = textView.text ?? ""
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let delegate = self.delegate else {return}
        delegate.updateHeightOfRow(self, textView)
    }
}
