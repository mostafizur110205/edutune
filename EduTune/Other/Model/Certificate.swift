//
//  Help.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 18, 2022
//
import Foundation
import SwiftyJSON

struct Certificate {

	var certificate_status: Int?
	var certificate_image: String?
    var certificate_default_image: String?
    var class_name: String?
    var certificate_message: String?
    var certificate_content: String?
    var class_id: Int?
    var is_completed: Int?
    var student_id: Int?

	init(_ json: JSON) {
        certificate_status = json["certificate_status"].int
        class_name = json["class_name"].string
        certificate_message = json["certificate_message"].string
        certificate_content = json["certificate_content"].string
        class_id = json["class_id"].int
        is_completed = json["is_completed"].int
        student_id = json["student_id"].int

        certificate_image = json["certificate_image"].string

        let cer = json["certificate_default_image"].stringValue
        if !cer.isEmpty {
            certificate_default_image = APIEndpoints.S3_URL + (AppDelegate.shared().uuid ?? "") + cer
        }
                
	}

}
