//
//  Feature.swift
//  Trendit
//
//  Created by Mostafizur Rahman on 2/7/22.
//

import SwiftyJSON

class Feature: NSObject {
    
    var id: Int?
    var order: Int?
    var institution_id: Int?
    var class_id: Int?

    var name: String?
    var value: String?
    var icon: String?

    required init(json: JSON) {
        id = json["id"].int
        order = json["order"].int
        institution_id = json["institution_id"].int
        class_id = json["class_id"].int

        name = json["name"].string
        value = json["value"].string
        icon = json["icon"].string

    }
}
