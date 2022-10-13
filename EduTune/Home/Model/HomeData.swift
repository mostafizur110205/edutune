//
//  Passion.swift
//  Trendit
//
//  Created by Mostafizur Rahman on 2/7/22.
//

import SwiftyJSON

class HomeData: NSObject {
    
    var helpline: String?
    var institution: Institution?
    var popup_advertisements_v2 = [Advertisement]()
    var program_wise_course = [Course]()
    var editors_choice = [Class]()
    var top_educators = [Teacher]()

    required init(json: JSON) {
        helpline = json["helpline"].string
        institution = Institution(json: json["institution"])
        popup_advertisements_v2 = json["popup_advertisements_v2"].arrayValue.map({ Advertisement(json: $0) })
        program_wise_course = json["program_wise_course"].arrayValue.map({ Course(json: $0) })
        editors_choice = json["editors_choice"].arrayValue.map({ Class(json: $0) })
        top_educators = json["top_educators"].arrayValue.map({ Teacher(json: $0) })
    }
}

class Institution: NSObject {
    
    var support_image: String?
    var support_text1: String?
    var support_text2: String?
    var support_text3: String?
    var support_title: String?
    var youtube_api_key: String?

    required init(json: JSON) {
        let pic = json["support_image"].stringValue
        if !pic.isEmpty {
            support_image = APIEndpoints.S3_URL + (AppDelegate.shared().uuid ?? "") + pic
        }
        
        support_text1 = json["support_text1"].string
        support_text2 = json["support_text2"].string
        support_text3 = json["support_text3"].string
        support_title = json["support_title"].string
        youtube_api_key = json["youtube_api_key"].string
    }
}

class Advertisement: NSObject {
    
    var image: String?
    var target: Int?
    var url: String?

    required init(json: JSON) {
        let pic = json["image"].stringValue
        if !pic.isEmpty {
            image = APIEndpoints.S3_URL + (AppDelegate.shared().uuid ?? "") + pic
        }
        
        target = json["target"].int
        url = json["url"].string
        
    }
}
