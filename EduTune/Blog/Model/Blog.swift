//
//  Blog.swift
//  Trendit
//
//  Created by Mostafizur Rahman on 2/7/22.
//

import SwiftyJSON

class Blog: NSObject {
    
    var id: Int?
    var type_name_id: Int?
    var author_id: Int?
    var institution_id: Int?
    
    var post_title: String?
    var post_content: String?
    var post_short_content: String?
    var post_image: String?
    var type: BlogType?

    required init(json: JSON) {
        id = json["id"].int
        type_name_id = json["type_name_id"].int
        author_id = json["author_id"].int
        institution_id = json["institution_id"].int
        
        post_title = json["post_title"].string
        post_content = json["post_content"].string
        post_short_content = json["post_short_content"].string
        type = BlogType(json: json["get_blog_type"])
        
        let pic = json["post_image"].stringValue
        if !pic.isEmpty {
            post_image = APIEndpoints.S3_URL + (AppDelegate.shared().uuid ?? "") + pic
        }
        
    }
}
