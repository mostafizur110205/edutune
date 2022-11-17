//
//  Notification.swift
//  Trendit
//
//  Created by Mostafizur Rahman on 2/7/22.
//

import SwiftyJSON

class Notification: NSObject {
    
    var id: Int?
    var message: String?
    var subject: String?
    
    required init(json: JSON) {
        id = json["id"].int
        message = json["message"].string
        subject = json["subject"].string
    }
}
