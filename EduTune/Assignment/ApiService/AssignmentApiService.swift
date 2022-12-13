//
//  AssignmentApiService.swift
//  EduTune
//
//  Created by DH on 13/12/22.
//

import Foundation
import SwiftyJSON
import SVProgressHUD

protocol AssignmentApiServiceProtocol {
    func getAssignmentQuestions(params: [String: Any], completion: @escaping (QuestionsModel?) -> Void)
}

final class AssignmentApiService: AssignmentApiServiceProtocol {
  
    func getAssignmentQuestions(params: [String : Any], completion: @escaping (QuestionsModel?) -> Void) {
        SVProgressHUD.show()
        APIRequest.shared.postRequest(url: APIEndpoints.MY_COURSE_ASSIGNMENTS_BEGIN, parameters: params) { (JSON, error) in
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            do {
                                let assignmentQuestions = try JSONDecoder().decode(QuestionsModel.self, from: json.rawData())
                                completion(assignmentQuestions)
                                print("assignment questions: \(assignmentQuestions)")
                            } catch {
                                print("Decoding Error : \(error)")
                            }
                        }
                    }
                }
            }
        }
    }
    
}
