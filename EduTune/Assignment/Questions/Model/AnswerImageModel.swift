//
//  AnswerImageModel.swift
//  EduTune
//
//  Created by DH on 31/12/22.
//

import UIKit

class AnswerImageModel {
    
    var id: Int
    var fileName: String?
    var filePath: String?
    var image: UIImage
    var isUploaded: Bool
    
    init(id: Int, fileName: String? = nil, filePath: String? = nil, image: UIImage, isUploaded: Bool) {
        self.id = id
        self.fileName = fileName
        self.filePath = filePath
        self.image = image
        self.isUploaded = isUploaded
    }
}
