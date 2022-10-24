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

//icon = "https://i.ibb.co/yqhQwCT/Group-22-2.png";
//id = 1;
//name = "Class 1";
