//
//  ClassDetail.swift
//  Trendit
//
//  Created by Mostafizur Rahman on 2/7/22.
//

import SwiftyJSON

class ClassDetail: NSObject {
    
    var id: Int?
    var name: String?
    var about: String?
    var photo: String?
    var certificate_image: String?
    var enrollment_link: String?
    var required_resourses = [String]()
    var current_price: Int?
    var original_price: Int?
    var program_name: String?
    var get_user_review_avg_rating: String?
    var reviews = [Review]()
    var get_features = [Feature]()
    var get_class_contents = [ClassContent]()
    var teachers = [Teacher]()
    var total_reviews: Int?

//    get_offered_coursesc
    

    required init(json: JSON) {
        id = json["id"].int
        name = json["name"].string
        about = json["about"].string
        enrollment_link = json["enrollment_link"].string
        required_resourses = json["required_resourses"].arrayValue.map({ $0.stringValue })
        current_price = json["current_price"].intValue
        original_price = json["original_price"].intValue
        program_name = json["program_name"].string
        get_user_review_avg_rating = json["get_user_review_avg_rating"].string
        reviews = json["reviews"]["data"].arrayValue.map({ Review(json: $0) })
        get_features = json["get_features"].arrayValue.map({ Feature(json: $0) })
        get_class_contents = json["get_class_contents"].arrayValue.map({ ClassContent(json: $0) })
        total_reviews = json["total_reviews"].int

        let pic = json["photo"].stringValue
        if !pic.isEmpty {
            photo = APIEndpoints.S3_URL + (AppDelegate.shared().uuid ?? "") + pic
        }
        
        let cer = json["certificate_image"].stringValue
        if !cer.isEmpty {
            certificate_image = APIEndpoints.S3_URL + (AppDelegate.shared().uuid ?? "") + cer
        }

    }
}
