//
//  Passion.swift
//  Trendit
//
//  Created by Mostafizur Rahman on 2/7/22.
//

import SwiftyJSON

class OnboardData: NSObject {
    
    var id: Int?
    var institution_id: Int?
    var splash_name: String?
    var image: String?
    var splash_order: Int?
    var is_enabled: Int?

    required init(json: JSON) {
        id = json["id"].int
        institution_id = json["institution_id"].int
        splash_name = json["splash_name"].string
        splash_order = json["splash_order"].int
        is_enabled = json["is_enabled"].int

        let pic = json["image"].stringValue
        if !pic.isEmpty {
            image = APIEndpoints.S3_URL + (AppDelegate.shared().uuid ?? "") + pic
        }
    }
}
