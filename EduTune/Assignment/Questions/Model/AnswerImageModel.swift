//
//  AnswerImageModel.swift
//  EduTune
//
//  Created by DH on 31/12/22.
//

import UIKit

class AnswerImageModel {
    
    var id: Int
    var filePath: String?
    var image: UIImage
    var isUploaded: Bool
    
    init(id: Int, filePath: String?, image: UIImage, isUploaded: Bool) {
        self.id = id
        self.filePath = filePath
        self.image = image
        self.isUploaded = isUploaded
    }
}
