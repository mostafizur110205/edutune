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
    var image: String?
    var created_at: String?

    required init(json: JSON) {
        id = json["id"].int
        message = json["message"].string
        subject = json["subject"].string
       
        if let pic = json["image"].string {
            image = APIEndpoints.S3_URL + (AppDelegate.shared().uuid ?? "") + pic
        }
        
        created_at = Notification.getDateTime(json["created_at"].string)
    }
    
    class func getDateTime(_ dateTime: String?) -> (String?) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormater.date(from: dateTime ?? "") {
            return date.dateStringWithFormat(format: "MMM d, yyyy")
        }else{
            return dateTime
        }
    }
}
