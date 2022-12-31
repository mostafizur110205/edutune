//
//  AssignmentsViewModel.swift
//  EduTune
//
//  Created by DH on 13/12/22.
//

import UIKit

protocol AssignmentsViewModelProtocol {
    
    func getAssignmentQuestions(params: [String: Any], completion: @escaping() -> Void)
    func showPhotoPromptActionSheet(controller: UIViewController)
    func openPhotoGallery(controller: UIViewController)
    func openCamera(controller: UIViewController)
    
    func uploadHtmlImage(imageModel: AnswerImageModel, completion: @escaping (AnswerImageModel?) -> Void)
    func uploadFile(imageModel: AnswerImageModel, completion: @escaping (AnswerImageModel?) -> Void)
}

class AssignmentsViewModel: AssignmentsViewModelProtocol {
    
    var apiService: AssignmentApiServiceProtocol
    var questionsModel :QuestionsModel?
    var fileAnswerImages = [AnswerImageModel]()
    var eassyAnswerImages = [AnswerImageModel]()
    var currentQuestionType: QuestionType?
    
    init(apiService: AssignmentApiServiceProtocol) {
        self.apiService = apiService
    }
    
    func getAssignmentQuestions(params: [String: Any], completion: @escaping() -> Void) {
        apiService.getAssignmentQuestions(params: params) {[weak self] questionsModel in
            self?.questionsModel = questionsModel
            completion()
        }
    }
    
    func showPhotoPromptActionSheet(controller: UIViewController) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.openCamera(controller: controller)
        }))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.openPhotoGallery(controller: controller)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        controller.present(actionSheet, animated: true, completion: nil)
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
    
    func deleteFile(imageModel model: AnswerImageModel, controller: AssignmentsVC) {
        for (index, item)  in eassyAnswerImages.enumerated() {
            if item.id == model.id {
                eassyAnswerImages.remove(at: index)
            }
        }
        controller.deleagte?.updateUploadedImages()
    }
    
    func uploadHtmlImage(imageModel: AnswerImageModel, completion: @escaping (AnswerImageModel?) -> Void) {
        
        let params = ["user_id": AppUserDefault.getUserId(),
                      "language":"en",
        ] as [String:Any]
        
        apiService.uploadHtmlEditorImage(params: params, imageModel: imageModel) { imageModel in
            guard let model = imageModel else {return}
            completion(model)
        }
    }
    
    func uploadFile(imageModel: AnswerImageModel, completion: @escaping (AnswerImageModel?) -> Void) {
        
        let params = ["user_id": AppUserDefault.getUserId(),
                      "language":"en",
        ] as [String:Any]
        
        apiService.uploadFiles(params: params, imageModel: imageModel) { imageModel in
            guard let model = imageModel else {return}
            completion(model)
        }
    }
}
