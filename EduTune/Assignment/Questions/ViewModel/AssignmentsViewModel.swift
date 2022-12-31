//
//  AssignmentsViewModel.swift
//  EduTune
//
//  Created by DH on 13/12/22.
//

import UIKit

protocol AssignmentsViewModelProtocol {
    
    func getAssignmentQuestions(params: [String: Any], completion: @escaping() -> Void)
    func openPhotoGallery(controller: UIViewController)
    func openCamera(controller: UIViewController)
    
    func uploadImage(imageModel: AnswerImageModel, completion: @escaping (AnswerImageModel?) -> Void)
}

class AssignmentsViewModel: AssignmentsViewModelProtocol {
    
    var apiService: AssignmentApiServiceProtocol
    var questionsModel :QuestionsModel?
    var answerImages = [AnswerImageModel]()
    
    init(apiService: AssignmentApiServiceProtocol) {
        self.apiService = apiService
    }
    
    func getAssignmentQuestions(params: [String: Any], completion: @escaping() -> Void) {
        apiService.getAssignmentQuestions(params: params) {[weak self] questionsModel in
            self?.questionsModel = questionsModel
            completion()
        }
    }
    
    func openPhotoGallery(controller: UIViewController) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = controller as? AssignmentsVC
            myPickerController.sourceType = .photoLibrary
            controller.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func openCamera(controller: UIViewController) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = controller as? AssignmentsVC
            myPickerController.sourceType = .camera
            controller.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func uploadImage(imageModel: AnswerImageModel, completion: @escaping (AnswerImageModel?) -> Void) {
        
        let params = ["user_id": AppUserDefault.getUserId(),
                      "language":"en",
        ] as [String:Any]
        
        apiService.uploadImage(params: params, imageModel: imageModel) { imageModel in
            guard let model = imageModel else {return}
            completion(model)
        }
    }
}
