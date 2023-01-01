//
//  AddProblemVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 30/10/22.
//

import UIKit
import Photos
import CropViewController

class AddProblemVC: UIViewController {
    
    @IBOutlet weak var problemTypeTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var chooseFileTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var problemType: ProblemType?
    var fileSelected: UIImage?
    
    let placeholder = "Description*"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        problemTypeTextField.delegate = self
        phoneTextField.delegate = self
        chooseFileTextField.delegate = self
        descriptionTextView.delegate = self
        
        phoneTextField.text = AppDelegate.shared().user?.phone
        
        descriptionTextView.textColor = .lightGray
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSubmitButtonTap(_ sender: Any) {
        
        let problemType = problemTypeTextField.text?.trim ?? ""
        let phone = phoneTextField.text?.trim ?? ""
        let description = descriptionTextView.text?.trim ?? ""
        
        if problemType.hasText && problemType.hasText && description.hasText {
            var params = ["problem_description": description, "mobile": phone, "problem_type": getProblemType(problemType), "user_id": AppUserDefault.getUserId()] as [String: Any]
            if let image = fileSelected, let strBase64 = self.resizeImage(image: image, targetSize: CGSize(width: 720, height: 720)).jpegData(compressionQuality: 1)?.base64EncodedString(options: .lineLength64Characters) {
                params["image"] = strBase64
            }
            
            APIService.shared.addProblem(params: params, completion: { photo in
                self.navigationController?.popViewController(animated: true)
                MakeToast.shared.makeNormalToast("Problem added successfully")
            })
        } else {
            MakeToast.shared.makeNormalToast("Please fill up all the required fields")
        }
        
    }
    
    func chooseProblemType() {
        self.view.endEditing(true)
        let data = [problemType?.error ?? "", problemType?.suggestion ?? "", problemType?.new_idea ?? ""]
        
        RPicker.selectOption(dataArray: data) {[weak self] (name, atIndex) in
            self?.problemTypeTextField.text = name
        }
    }
    
    func getProblemType(_ type: String) -> String {
        if problemType?.error == type {
            return "error"
        } else if problemType?.suggestion == type {
            return "suggestion"
        } else {
            return "new_idea"
        }
    }
    
    func chooseFile() {
        self.view.endEditing(true)
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraActionButton = UIAlertAction(title: "Camera", style: .default, handler:{ (UIAlertAction)in
            print("Camera")
            
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
                if granted {
                    DispatchQueue.main.async(execute: {
                        self.openSource(UIImagePickerController.SourceType.camera)
                    })
                } else {
                    DispatchQueue.main.async(execute: {
                        MakeToast.shared.makeNormalToast("Edutune needs access to the camera")
                    })
                }
            })
        })
        alert.addAction(cameraActionButton)
        
        let photosActionButton = UIAlertAction(title: "Photo Library", style: .default, handler: { (UIAlertAction)in
            print("Photos")
            
            PHPhotoLibrary.requestAuthorization({ status in
                switch status {
                case .authorized:
                    DispatchQueue.main.async(execute: {
                        self.openSource(UIImagePickerController.SourceType.photoLibrary)
                    })
                default:
                    DispatchQueue.main.async(execute: {
                        MakeToast.shared.makeNormalToast("Edutune needs access to the photo library")
                    })
                }
            })
        })
        alert.addAction(photosActionButton)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction)in
            print("Cancel")
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func openSource(_ sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = sourceType
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        } else {
            //            DVAlertViewController.showCommonAlert(title: "Alert", message: "Sorry, this feature is not compatible with your phone", controller: self)
        }
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if (widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}

extension AddProblemVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        self.dismiss(animated: true, completion: nil)
        if let anImage = info[.originalImage] as? UIImage {
            
            let cropViewController = CropViewController(croppingStyle: .default, image: anImage)
            cropViewController.delegate = self
            present(cropViewController, animated: true, completion: nil)
        }
    }
}

extension AddProblemVC: CropViewControllerDelegate {
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        
        let viewController = cropViewController.children.first!
        viewController.modalTransitionStyle = .coverVertical
        viewController.presentingViewController?.dismiss(animated: true, completion: nil)
        
        self.fileSelected = image
        self.chooseFileTextField.text = "image.jpg"
    }
    
}


extension AddProblemVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == problemTypeTextField {
            chooseProblemType()
            return false
        } else  if textField == chooseFileTextField {
            chooseFile()
            return false
        }
        return true
    }
    
}

extension AddProblemVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text.trim == placeholder {
            textView.text = ""
        }
        textView.textColor = UIColor.black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trim == "" {
            textView.textColor = .lightGray
            textView.text = placeholder
        }else{
            textView.textColor = UIColor.black
        }
    }
    
}
