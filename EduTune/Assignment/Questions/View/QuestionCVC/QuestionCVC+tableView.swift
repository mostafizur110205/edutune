//
//  QuestionCVC+tableView.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 17/12/22.
//

import UIKit

extension QuestionCVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionItem?.questionOptions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch questionItem?.questionType {
        case .shortAnswer:
            return UITableView.automaticDimension
        case .fileResponse:
            return frame.height/1.4
        case .essay:
            return frame.height * 1.1
        default:
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = QuestionHeaderView()
        view.titleLabel.text = questionItem?.htmlTitle?.htmlToAttributedString?.string.trimmingCharacters(in: .whitespaces)
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
            cell.viewModel = viewModel
            cell.viewController = viewController
            return cell
            
        case .filInTheBlanks:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionSevenTVC") as? QuestionSevenTVC
            else {return UITableViewCell()}
            cell.selectionStyle = .none
            cell.contentView.isUserInteractionEnabled = false
            cell.viewModel = viewModel
            cell.questionItem = questionItem
            return cell
            
        case .fileResponse:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionNineTVC") as? QuestionNineTVC
            else {return UITableViewCell()}
            cell.selectionStyle = .none
            cell.viewModel = viewModel
            cell.viewController = viewController
            return cell
            
        case .shortAnswer:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionElevenTVC") as? QuestionElevenTVC
            else {return UITableViewCell()}
            cell.selectionStyle = .none
            cell.contentView.isUserInteractionEnabled = false
            cell.viewModel = viewModel
            cell.delegate = self
            return cell
            
        case .none:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch questionItem?.questionType {
        case .multipleChoice, .trueFalse:
            
            guard let id = questionItem?.questionOptions?[indexPath.row].id,
                  let model = viewModel else {return}
            
            /* append selected option id to the anserId list */
            viewModel?.questionsModel?.questionItems?[model.questionIndex].answerOptionIds = [id]
            
            questionItem?.questionOptions?[indexPath.row].isSelected = true
            let _ = (questionItem?.questionOptions?.filter {$0.id != id}.map {$0.isSelected = false})
            
        case .multipleAnswer:
            
            guard let isSelected = questionItem?.questionOptions?[indexPath.row].isSelected,
                  let model = viewModel else {return}
            
            questionItem?.questionOptions?[indexPath.row].isSelected = !isSelected
            
            if let selectedOption = questionItem?.questionOptions?.filter({$0.isSelected == true}).map({$0.id ?? 0}) {
                /* append selected option id to the anserId list */
                viewModel?.questionsModel?.questionItems?[model.questionIndex].answerOptionIds = selectedOption
            }
            
        case .none, .essay, .shortAnswer, .filInTheBlanks, .fileResponse:
            
            print("none")
        }
        tableView.reloadData()
    }
}

