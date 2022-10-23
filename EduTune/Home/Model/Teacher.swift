//
//  Teacher.swift
//  Trendit
//
//  Created by Mostafizur Rahman on 2/7/22.
//

import SwiftyJSON

class Teacher: NSObject {
    
    var id: Int?
    var student_count: Int?
    var designation_name: String?
    var name: String?
    var portfolio_photo: String?
    var detail: String?
    var class_count: Int?

    required init(json: JSON) {
        id = json["id"].int
        student_count = json["student_count"].int
        designation_name = json["designation_name"].string
        name = json["name"].string
        detail = json["detail"].string

        if let pic = json["portfolio_photo"].string {
            portfolio_photo = APIEndpoints.S3_URL + (AppDelegate.shared().uuid ?? "") + pic
        } else if let pic2 = json["photo"].string {
            portfolio_photo = APIEndpoints.S3_URL + (AppDelegate.shared().uuid ?? "") + pic2
        }
    }
}
