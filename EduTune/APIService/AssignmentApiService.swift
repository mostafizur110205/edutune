//
//  AssignmentApiService.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 13/12/22.
//

import Foundation
import SwiftyJSON

protocol AssignmentApiServiceProtocol {
    func getAssignmentQuestions(params: [String: Any], completion: @escaping (QuestionsModel?) -> Void)
    func uploadHtmlEditorImage(params: [String: Any], imageModel: AnswerImageModel, completion: @escaping (AnswerImageModel?) -> Void)
    func uploadFiles(params: [String: Any], imageModel: AnswerImageModel, completion: @escaping (AnswerImageModel?) -> Void)
    func submitAssignment(withAnswers params: [String: Any], completion: @escaping (Bool) -> Void) 
}

final class AssignmentApiService: AssignmentApiServiceProtocol {
    
    func getAssignmentQuestions(params: [String : Any], completion: @escaping (QuestionsModel?) -> Void) {
        APIRequest.shared.postRequest(url: APIEndpoints.MY_COURSE_ASSIGNMENT_BEGIN, parameters: params) { (JSON, error) in
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
    
    func uploadHtmlEditorImage(params: [String: Any], imageModel: AnswerImageModel, completion: @escaping (AnswerImageModel?) -> Void) {
        APIRequest.shared.uploadImage(url: APIEndpoints.MY_COURSE_ASSIGNMENT_HTML_EDITOR_IMAGE_UPLOAD, image: imageModel.image, parameters: params) { JSON, error in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            let imageUrl = json["uploaded_files"].array?.first?.stringValue
                            imageModel.filePath = imageUrl
                            imageModel.isUploaded = true
                            completion(imageModel)
                        }
                    }
                }
            }
        }
    }
    
    func uploadFiles(params: [String: Any], imageModel: AnswerImageModel, completion: @escaping (AnswerImageModel?) -> Void) {
        APIRequest.shared.uploadImage(url: APIEndpoints.MY_COURSE_ASSIGNMENT_FILE_UPLOAD, image: imageModel.image, parameters: params) { JSON, error in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            let imageUrl = json["uploaded_files"].array?.first?.stringValue
                            imageModel.filePath = imageUrl
                            imageModel.isUploaded = true
                            completion(imageModel)
                        }
                    }
                }
            }
        }
    }
    
    func submitAssignment(withAnswers params: [String: Any], completion: @escaping (Bool) -> Void) {
        APIRequest.shared.postRequestJSON(url: APIEndpoints.MY_COURSE_ASSIGNMENT_SUBMIT, parameters: params) { (JSON, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            completion(true)
                            MakeToast.shared.makeNormalToast(json["message"].stringValue)
                        } else {
                            completion(false)
                            MakeToast.shared.makeNormalToast(json["message"].stringValue)
                        }
                    }
                }
            }
        }
    }
    
}
