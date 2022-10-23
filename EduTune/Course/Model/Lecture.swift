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

    var title: String?
    var type_icon: String?

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

        title = json["title"].string
        type_icon = json["type_icon"].string

    }
}
