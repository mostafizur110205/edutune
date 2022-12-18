//
//  QuestionCVC+tableView.swift
//  EduTune
//
//  Created by DH on 17/12/22.
//

import UIKit

extension QuestionCVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionItem?.questionOptions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = QuestionHeaderView()
        view.titleLabel.attributedText = questionItem?.htmlTitle?.htmlToAttributedString
        return view
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch questionItem?.questionType {
        case .multipleChoice, .trueFalse:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionOneTVC") as? QuestionOneTVC
            else {return UITableViewCell()}
            cell.selectionStyle = .none
            cell.questionOptions = questionItem?.questionOptions?[indexPath.row]
            return cell
            
        case .multipleAnswer:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTwoTVC") as? QuestionTwoTVC
            else {return UITableViewCell()}
            cell.selectionStyle = .none
            cell.questionOptions = questionItem?.questionOptions?[indexPath.row]
            return cell
            
        case .essay:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionFourTVC") as? QuestionFourTVC
            else {return UITableViewCell()}
            cell.selectionStyle = .none
            return cell
            
        case .filInTheBlanks:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionSevenTVC") as? QuestionSevenTVC
            else {return UITableViewCell()}
            cell.selectionStyle = .none
            cell.questionItem = questionItem
            return cell
            
        case .fileResponse:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionNineTVC") as? QuestionNineTVC
            else {return UITableViewCell()}
            cell.selectionStyle = .none
            return cell
            
        case .shortAnswer:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionElevenTVC") as? QuestionElevenTVC
            else {return UITableViewCell()}
            cell.selectionStyle = .none
            return cell
            
        case .none:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

