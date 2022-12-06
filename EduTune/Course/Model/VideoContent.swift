//
//  Lecture.swift
//  Trendit
//
//  Created by Mostafizur Rahman on 2/7/22.
//

import SwiftyJSON

class VideoContent: NSObject {
    
    var id: Int?
    var video_type: Int?
    var video_content_category_id: Int?
    var video_id: String?
    var image: String?
    var time: Int?

    required init(json: JSON) {
        id = json["id"].int
        video_type = json["video_type"].int
        video_content_category_id = json["video_content_category_id"].int
        video_id = json["video_id"].string
        time = json["time"].int

        let img = json["image"].stringValue
        if !img.isEmpty {
            image = APIEndpoints.S3_URL + (AppDelegate.shared().uuid ?? "") + img
        }
    }
}
