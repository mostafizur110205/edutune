//
//  Review.swift
//  Trendit
//
//  Created by Mostafizur Rahman on 2/7/22.
//

import SwiftyJSON

class Review: NSObject {
    
    var id: Int?
    var institution_id: Int?
    var class_id: Int?
    var user_id: Int?
    var rating: Int?
    var like_count: Int?

    var comment: String?
    var username: String?
    var photo: String?

    required init(json: JSON) {
        id = json["id"].int
        institution_id = json["institution_id"].int
        class_id = json["class_id"].int
        user_id = json["user_id"].int
        rating = json["rating"].int
        like_count = json["like_count"].int

        comment = json["comment"].string
        username = json["username"].string
       
        let pic = json["photo"].stringValue
        if !pic.isEmpty {
            photo = APIEndpoints.S3_URL + (AppDelegate.shared().uuid ?? "") + pic
        }

    }
}
