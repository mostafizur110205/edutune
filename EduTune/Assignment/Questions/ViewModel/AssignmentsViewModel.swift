//
//  AssignmentsViewModel.swift
//  EduTune
//
//  Created by DH on 13/12/22.
//

import Foundation

protocol AssignmentsViewModelProtocol {
    func getAssignmentQuestions(params: [String: Any], completion: @escaping() -> Void)
}

class AssignmentsViewModel: AssignmentsViewModelProtocol {
    
    var apiService: AssignmentApiServiceProtocol
    var questionsModel :QuestionsModel?
    
    init(apiService: AssignmentApiServiceProtocol) {
        self.apiService = apiService
    }
    
    func getAssignmentQuestions(params: [String: Any], completion: @escaping() -> Void) {
        apiService.getAssignmentQuestions(params: params) {[weak self] questionsModel in
            self?.questionsModel = questionsModel
            completion()
        }
    }
}
