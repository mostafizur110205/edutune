//
//  AssignmentsVC+imagePicker.swift
//  EduTune
//
//  Created by DH on 31/12/22.
//

import UIKit
import AVFoundation

extension AssignmentsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            switch viewModel?.currentQuestionType {
            case .essay:
                var fileName: String
                if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                     fileName = url.lastPathComponent
                } else {
                    fileName = "\(Date.currentTimeStamp)"
                }
                eassyImagePick(withImage: image, fileName: fileName)
            case .fileResponse:
                fileResponseImagePick(withImage: image)
            default:
                print("others question type")
            }
            self.dismiss(animated: true, completion: nil)
            
        } else {
            print("Something went wrong")
        }
    }
    
    private func fileResponseImagePick(withImage image: UIImage) {
        
        let model = AnswerImageModel(id: Date.currentTimeStamp, image: image, isUploaded: false)
        
        guard let _viewModel = viewModel,
              let delegate = self.deleagte else {return}
        
        _viewModel.questionsModel?.questionItems?[_viewModel.questionIndex].assignmentFiles.append(model)
        delegate.updateUploadedImages()
        
        _viewModel.uploadFile(imageModel: model, completion: {[weak self] imageModel in
            
            guard let image = imageModel,
                  let assignmentFiles = _viewModel.questionsModel?.questionItems?[_viewModel.questionIndex].assignmentFiles else {return}
            
            for (index, item)  in assignmentFiles.enumerated() {
                if item.id == image.id {
                    _viewModel.questionsModel?.questionItems?[_viewModel.questionIndex].assignmentFiles.remove(at: index)
                    _viewModel.questionsModel?.questionItems?[_viewModel.questionIndex].assignmentFiles.insert(image, at: index)
                }
            }
            self?.deleagte?.updateUploadedImages()
        })
    }
    
    private func eassyImagePick(withImage image: UIImage, fileName: String) {
        
        let model = AnswerImageModel(id: Date.currentTimeStamp, fileName: fileName, image: image, isUploaded: false)
     
        guard let _viewModel = viewModel,
              let delegate = self.deleagte else {return}
        
        _viewModel.questionsModel?.questionItems?[_viewModel.questionIndex].assignmentFiles.append(model)
        delegate.updateUploadedImages()
        
        viewModel?.uploadHtmlImage(imageModel: model, completion: {[weak self] imageModel in
            
            guard let image = imageModel,
                  let assignmentFiles = _viewModel.questionsModel?.questionItems?[_viewModel.questionIndex].assignmentFiles else {return}
            
            for (index, item)  in assignmentFiles.enumerated() {
                if item.id == image.id {
                    _viewModel.questionsModel?.questionItems?[_viewModel.questionIndex].assignmentFiles.remove(at: index)
                    _viewModel.questionsModel?.questionItems?[_viewModel.questionIndex].assignmentFiles.insert(image, at: index)
                }
            }
            self?.deleagte?.updateUploadedImages()
        })
    }
}
