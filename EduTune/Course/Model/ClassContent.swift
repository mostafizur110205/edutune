//
//  Lecture.swift
//  Trendit
//
//  Created by Mostafizur Rahman on 2/7/22.
//

import SwiftyJSON

class ClassContent: NSObject {
    
    var id: Int?
    var order: Int?
    var institution_id: Int?
    var class_id: Int?
    var offered_course_id: Int?
   
    var title: String?
    var get_lectures = [Lecture]()

    required init(json: JSON) {
        id = json["id"].int
        order = json["order"].int
        institution_id = json["institution_id"].int
        offered_course_id = json["offered_course_id"].int
        class_id = json["class_id"].int
        get_lectures = json["get_lectures"].arrayValue.map({ Lecture(json: $0) })

        title = json["title"].string

    }
}

class ClassContentView: NSObject {
    
    var id: Int?
    var count: Int?
    var institution_id: Int?
    var user_id: Int?
    var class_id: Int?
    var offered_course_id: Int?
   

    required init(json: JSON) {
        id = json["id"].int
        count = json["count"].int
        institution_id = json["institution_id"].int
        user_id = json["user_id"].int
        class_id = json["class_id"].int
        offered_course_id = json["offered_course_id"].int

    }
}
