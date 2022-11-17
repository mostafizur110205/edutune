//
//  Class.swift
//  Trendit
//
//  Created by Mostafizur Rahman on 2/7/22.
//

import SwiftyJSON

class Class: NSObject {
    
    var id: Int?
    var current_price: Int?
    var original_price: Int?
    var subject_count: Int?
    var is_show_details: Int?
    var mode: Int?

    var get_user_review_avg_rating: String?
    var name: String?
    var program_name: String?
    var total_duration: String?
    var youtube_video_id: String?
    var photo: String?

    var class_book_mark_id: Int?
    
    required init(json: JSON) {
        id = json["id"].int
        current_price = json["current_price"].intValue
        original_price = json["original_price"].intValue
        subject_count = json["subject_count"].int
        is_show_details = json["is_show_details"].int
        mode = json["mode"].int

        get_user_review_avg_rating = json["get_user_review_avg_rating"].string
        name = json["name"].string
        program_name = json["program_name"].string
        total_duration = json["total_duration"].string
        youtube_video_id = json["youtube_video_id"].string
        
        let pic = json["photo"].stringValue
        if !pic.isEmpty {
            photo = APIEndpoints.S3_URL + (AppDelegate.shared().uuid ?? "") + pic
        }
        
        class_book_mark_id = json["class_book_mark_id"].int ?? (json["get_user_book_mark"]["id"].int ?? nil)

    }
}
