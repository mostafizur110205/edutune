//
//  BlogType.swift
//  Trendit
//
//  Created by Mostafizur Rahman on 2/7/22.
//

import SwiftyJSON

class BlogType: NSObject {
    
    var id: Int?
    var institution_id: Int?
    var type_name: String?

    required init(json: JSON) {
        id = json["id"].int
        institution_id = json["institution_id"].int
        type_name = json["type_name"].string

    }
}
