//
//  AssignmentApiService.swift
//  EduTune
//
//  Created by DH on 13/12/22.
//

import Foundation
import SwiftyJSON

protocol AssignmentApiServiceProtocol {
    func getAssignmentQuestions(params: [String: Any], completion: @escaping (QuestionsModel?) -> Void)
    func uploadImage(params: [String: Any], imageModel: AnswerImageModel, completion: @escaping (AnswerImageModel?) -> Void)
}

final class AssignmentApiService: AssignmentApiServiceProtocol {
    
    func getAssignmentQuestions(params: [String : Any], completion: @escaping (QuestionsModel?) -> Void) {
        APIRequest.shared.postRequest(url: APIEndpoints.MY_COURSE_ASSIGNMENTS_BEGIN, parameters: params) { (JSON, error) in
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
    
    func uploadImage(params: [String: Any], imageModel: AnswerImageModel, completion: @escaping (AnswerImageModel?) -> Void) {
        APIRequest.shared.uploadImage(url: APIEndpoints.MY_COURSE_ASSIGNMENTS_IMAGE_UPLOAD, image: imageModel.image, parameters: params) { JSON, error in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            let imageUrl = json["uploaded_files"].string
                            imageModel.filePath = imageUrl
                            imageModel.isUploaded = true
                            completion(imageModel)
                        }
                    }
                }
            }
        }
    }
    
}
