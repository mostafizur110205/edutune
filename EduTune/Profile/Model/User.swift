//
//  User.swift
//  Trendit
//
//  Created by Mostafizur Rahman on 2/7/22.
//

import SwiftyJSON

class User: NSObject {
    
    var user_id: Int?
    var user_type: Int?
    var institution_id: Int?

    var phone: String?
    var bearer_token: String?
    var username: String?
    var email: String?
    var designation: String?
    var ref_code: String?
    var photo: String?
    var language: String?
    var institution_url: String?
    var institution_logo: String?
    var institution_name: String?
    var goal: UserGoal?
    var group: UserGoal?

    required init(json: JSON) {
        user_id = json["user_id"].int
        user_type = json["user_type"].int
        institution_id = json["institution_id"].int

        phone = json["phone"].stringValue
        bearer_token = json["bearer_token"].string
        username = json["username"].string
        email = json["email"].string
        designation = json["designation"].string
        ref_code = json["ref_code"].string
        photo = json["photo"].string
        language = json["language"].string
        institution_url = json["institution_url"].string
        institution_logo = json["institution_logo"].string
        institution_name = json["institution_name"].string

    }
}

class UserProfile: NSObject {
    
    var student_id: Int?
    var name: String?
    var dob: String?
    var email: String?
    var mobile_number: String?
    var guardian_name: String?
    var guardian_mobile: String?

    required init(json: JSON) {
        student_id = json["student_id"].int
        name = json["name"].stringValue
        dob = json["dob"].string
        email = json["email"].string
        mobile_number = json["mobile_number"].string
        guardian_name = json["guardian_name"].string
        guardian_mobile = json["guardian_mobile"].string
    
    }
}
