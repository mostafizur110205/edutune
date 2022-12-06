//
//  Lecture.swift
//  Trendit
//
//  Created by Mostafizur Rahman on 2/7/22.
//

import SwiftyJSON

class Lecture: NSObject {
    
    var id: Int?
    var order: Int?
    var institution_id: Int?
    var class_content_id: Int?
    var type: Int?
    var length: Int?
    var is_protected: Int?
    var linked_lecture_id: Int?
    var linked_assignment_id: Int?
    var youtube_id: String?
   
    var title: String?
    var type_icon: String?
    var get_class_content_view: ClassContentView?
    var get_video_content: VideoContent?

    required init(json: JSON) {
        id = json["id"].int
        order = json["order"].int
        institution_id = json["institution_id"].int
        class_content_id = json["class_content_id"].int
        type = json["type"].int
        length = json["length"].int
        is_protected = json["is_protected"].int
        linked_lecture_id = json["linked_lecture_id"].int
        linked_assignment_id = json["linked_assignment_id"].int
        youtube_id = json["youtube_id"].string

        title = json["title"].string
        type_icon = json["type_icon"].string
        get_class_content_view = ClassContentView(json: json["get_class_content_lecture_view"])
        get_video_content = VideoContent(json: json["get_video_content"])

    }
}
