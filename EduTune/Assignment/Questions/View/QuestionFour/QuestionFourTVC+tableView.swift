//
//  QuestionFourTVC+tableView.swift
//  EduTune
//
//  Created by DH on 1/1/23.
//

import UIKit

extension QuestionFourTVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let model = viewModel,
              let assignmentsFiles = model.questionsModel?.questionItems?[model.questionIndex].assignmentFiles
        else {return 0}
        
        return assignmentsFiles.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view = SelectFileHeaderView()
        view.viewModel = viewModel
        view.viewController = viewController
        viewController?.deleagte = self
        view.isUserInteractionEnabled = true
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FileNameTVC") as? FileNameTVC,
              let model = viewModel,
              let assignmentsFiles = model.questionsModel?.questionItems?[model.questionIndex].assignmentFiles
        else {return UITableViewCell()}
        
        cell.selectionStyle = .none
        cell.viewModel = viewModel
        cell.viewController = viewController
        
        cell.imageModel = assignmentsFiles[indexPath.row]
        return cell
    }
    
}
