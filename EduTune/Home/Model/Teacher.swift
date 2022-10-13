//
//  Passion.swift
//  Trendit
//
//  Created by Mostafizur Rahman on 2/7/22.
//

import SwiftyJSON

class Teacher: NSObject {
    
    var id: Int?
    var designation_name: String?
    var name: String?
    var portfolio_photo: String?

    required init(json: JSON) {
        id = json["id"].int

        designation_name = json["designation_name"].string
        name = json["name"].string

        let pic = json["portfolio_photo"].stringValue
        if !pic.isEmpty {
            portfolio_photo = APIEndpoints.S3_URL + (AppDelegate.shared().uuid ?? "") + pic
        }

    }
}
