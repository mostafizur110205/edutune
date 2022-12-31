//
//  QuestionFourTVC+tableView.swift
//  EduTune
//
//  Created by DH on 1/1/23.
//

import UIKit

extension QuestionFourTVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.eassyAnswerImages.count ?? 0
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FileNameTVC") as? FileNameTVC
        else {return UITableViewCell()}
        cell.selectionStyle = .none
        cell.viewModel = viewModel
        cell.viewController = viewController
        cell.imageModel = viewModel?.eassyAnswerImages[indexPath.row]
        return cell
    }
    
}
