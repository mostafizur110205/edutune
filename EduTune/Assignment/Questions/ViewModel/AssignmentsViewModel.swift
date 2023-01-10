//
//  AssignmentsViewModel.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 13/12/22.
//

import UIKit

protocol AssignmentsViewModelProtocol {
    
    var apiService: AssignmentApiServiceProtocol {get}
    var questionsModel :QuestionsModel? {get}
    var questionIndex: Int {get}
    
    func getAssignmentQuestions(params: [String: Any], completion: @escaping() -> Void)
    func setCurrentQuestion(collectionViewCellIndex index: Int)
    func showPhotoPromptActionSheet(controller: UIViewController)
    func openPhotoGallery(controller: UIViewController)
    func openCamera(controller: UIViewController)
    
    func uploadHtmlImage(imageModel: AnswerImageModel, completion: @escaping (AnswerImageModel?) -> Void)
    func uploadFile(imageModel: AnswerImageModel, completion: @escaping (AnswerImageModel?) -> Void)
}

class AssignmentsViewModel: AssignmentsViewModelProtocol {
    
    var apiService: AssignmentApiServiceProtocol
    var questionsModel: QuestionsModel?
    
    /* this is question item collection view current/visible cell index number */
    private(set) var questionIndex: Int
    var currentQuestionType: QuestionType?
    
    init(apiService: AssignmentApiServiceProtocol) {
        self.apiService = apiService
        questionIndex = 0
    }
    
    func getAssignmentQuestions(params: [String: Any], completion: @escaping() -> Void) {
        apiService.getAssignmentQuestions(params: params) {[weak self] questionsModel in
            self?.questionsModel = questionsModel
            completion()
        }
    }
    
    func setCurrentQuestion(collectionViewCellIndex index: Int) {
        questionIndex = index
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
        
        guard let assignmentFiles = questionsModel?.questionItems?[questionIndex].assignmentFiles else {return}
        
        for (index, item)  in assignmentFiles.enumerated() {
            if item.id == model.id {
                questionsModel?.questionItems?[questionIndex].assignmentFiles.remove(at: index)
            }
        }
        controller.deleagte?.updateUploadedImages()
    }
    
    func getHtmlTextFrom(richText text: String) -> String {
        // Remove spaces between HTML tags.
        let regex = try! NSRegularExpression(pattern: ">\\s+?<", options: .caseInsensitive)
        let range = NSMakeRange(0, text.count)
        let htmlFormText = regex.stringByReplacingMatches(in: text, options: .reportCompletion, range: range, withTemplate: "><")
        return htmlFormText
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
    
    func submitAssignment(completion: @escaping () -> Void) {
        
        var questionAnswer = [Any]()
        
        /* True-False, Multiple Choice, Multiple Answer : Question type 1 2 3 */
        let tfMulChAnsItems = questionsModel?.questionItems?.filter {
            $0.questionType == .trueFalse ||
            $0.questionType == .multipleAnswer ||
            $0.questionType == .multipleChoice
        }
        
        if let items = tfMulChAnsItems {
            
            for (index,item) in items.enumerated() {
                
                let params = ["question_id": item.questionOptions?[index].questionId ?? 0,
                              "question_type": item.questionType?.rawValue ?? 0,
                              "answer": [
                                "option_ids" : item.answerOptionIds
                              ]
                ] as [String:Any]
                
                questionAnswer.append(params)
            }
        }
        
        /* Fill in the Blanks, Short Answer : Question type 7, 11 */
        let filIShortItems = questionsModel?.questionItems?.filter {
            $0.questionType == .filInTheBlanks ||
            $0.questionType == .shortAnswer
        }
        if let items = filIShortItems {

            for (_,item) in items.enumerated() {

                var answerValue : [String:Any]
                if item.questionType == .filInTheBlanks {
                    answerValue = ["answer_object" : ["1" : item.answer]]
                } else {
                    answerValue = ["answer_text" : item.answer]
                }

                let params = ["question_id": item.id ?? 0,
                              "question_type": item.questionType?.rawValue ?? 0,
                              "answer": answerValue
                ] as [String:Any]

                questionAnswer.append(params)
            }
        }
        
        /* Eassy, File Response: Question type 4,9 */
        let eassyFile = questionsModel?.questionItems?.filter {
            $0.questionType == .essay ||
            $0.questionType == .fileResponse
        }

        if let items = eassyFile {

            for (_,item) in items.enumerated() {

                let files = item.assignmentFiles.map{$0.filePath}
                let params = ["question_id": item.id ?? 0,
                              "question_type": item.questionType?.rawValue ?? 0,
                              "answer": [
                                "answer_file_path" : files,
                                "answer_text" : item.answer
                              ]
                ] as [String:Any]

                questionAnswer.append(params)
            }
        }
        
        let params = ["user_id": AppUserDefault.getUserId(),
                      "test_id": questionsModel?.test_id ?? 0,
                      "assignment_id": questionsModel?.questionItems?[0].assignmentId ?? 0,
                      "class_id": questionsModel?.questionItems?[0].classId ?? 0,
                      "is_submit": "1",
                      "question_answer": questionAnswer
        ] as [String:Any]
        
        apiService.submitAssignment(withAnswers: params) { isSubmitted in
            completion()
        }
        
    }
}
