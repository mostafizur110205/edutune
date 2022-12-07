//
//  LectureHost.swift
//  Trendit
//
//  Created by Mostafizur Rahman on 2/7/22.
//

import SwiftyJSON

class LectureHost: NSObject {
    
    var id: Int?
    var host_link: String?
    var host_name: String?
    var zoom_sdk_app_key: String?
    var zoom_sdk_app_secret: String?

    required init(json: JSON) {
        id = json["id"].int
        host_link = json["host_link"].string
        host_name = json["host_name"].string
        zoom_sdk_app_key = json["zoom_sdk_app_key"].string
        zoom_sdk_app_secret = json["zoom_sdk_app_secret"].string
    }
}
