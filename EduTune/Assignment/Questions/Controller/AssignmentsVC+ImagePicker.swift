//
//  AssignmentsVC+imagePicker.swift
//  EduTune
//
//  Created by DH on 31/12/22.
//

import UIKit

extension AssignmentsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            let model = AnswerImageModel(id: Date.currentTimeStamp, filePath: nil, image: image, isUploaded: false)
            viewModel?.answerImages.append(model)
            guard let delegate = self.deleagte else {return}
            delegate.updateUploadedImages()
            
            viewModel?.uploadImage(imageModel: model, completion: {[weak self] imageModel in
                
                guard let model = self?.viewModel,
                      let image = imageModel else {return}
                
                for (index, item)  in model.answerImages.enumerated() {
                    if item.id == image.id {
                        model.answerImages.remove(at: index)
                        model.answerImages.insert(image, at: index)
                    }
                }
                self?.deleagte?.updateUploadedImages()
            })
            self.dismiss(animated: true, completion: nil)
            
        } else {
            print("Something went wrong")
        }
    }
}
