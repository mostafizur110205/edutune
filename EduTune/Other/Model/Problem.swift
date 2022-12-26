//
//  Problem.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 18, 2022
//
import Foundation
import SwiftyJSON

struct Problem {

    var id: Int?
    var problem_module: String?
	var problem_type: String?
    var mobile: String?
    var email: String?
    var problem_description: String?
    var status: Int?
    var comment: String?
    var created_at: String?
    var image: String?

	init(_ json: JSON) {
        id = json["id"].int
        problem_module = json["problem_module"].string
        problem_type = json["problem_type"].string
        mobile = json["mobile"].string
        email = json["email"].string
        problem_description = json["problem_description"].string
        status = json["status"].int
        comment = json["comment"].string
        created_at = json["created_at"].string

        let pic = json["image"].stringValue
        if !pic.isEmpty {
            image = APIEndpoints.S3_URL + (AppDelegate.shared().uuid ?? "") + pic
        }
        
	}
    
}

struct ProblemType {
    var error: String?
    var suggestion: String?
    var new_idea: String?

    init(_ json: JSON) {
        error = json["error"].string
        suggestion = json["suggestion"].string
        new_idea = json["new_idea"].string

    }
}
