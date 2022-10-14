//
//  Passion.swift
//  Trendit
//
//  Created by Mostafizur Rahman on 2/7/22.
//

import SwiftyJSON

class Program: NSObject {
    
    var id: Int?
    var institution_id: Int?
    var program_order: Int?
    var department_id: Int?
    var get_classes_count: Int?
    var menu_title: String?
    var program_name: String?
    var slug: String?
    var getClasses = [Class]()

    required init(json: JSON) {
        id = json["id"].int
        institution_id = json["institution_id"].int
        program_order = json["program_order"].int
        department_id = json["department_id"].int
        get_classes_count = json["get_classes_count"].int
        menu_title = json["menu_title"].string
        program_name = json["program_name"].string
        slug = json["slug"].string
        getClasses = json["getClasses"].arrayValue.map({ Class(json: $0) })

    }
}

//file = "<null>";
//"program_length" = "<null>";
