//
//  BlogAPIService.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 16/11/22.
//

import UIKit
import SwiftyJSON
import SVProgressHUD

extension APIService {

    func getBlogs(page: Int, params: [String: Any], completion: @escaping ([Blog], [BlogType], Int, Int) -> Void) {
        APIRequest.shared.getRequest(url: APIEndpoints.BLOG+"?page=\(page)", parameters: params) { (JSON, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            let blogs = json["blogs"]["data"].arrayValue.map { Blog(json: $0) }
                            let types = json["blog_types"].arrayValue.map { BlogType(json: $0) }
                            let currentPage = json["blogs"]["current_page"].intValue
                            let lastPage = json["blogs"]["last_page"].intValue
                            completion(blogs, types, currentPage, lastPage)
                        }
                    }
                }
            }
        }
    }
    
    func getBlogBookmarks(params: [String: Any], completion: @escaping ([Blog]) -> Void) {
        APIRequest.shared.getRequest(url: APIEndpoints.BLOG, parameters: params) { (JSON, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            let blogs = json["blog_user_bookmark_blog_list"].arrayValue.map { Blog(json: $0) }
                            completion(blogs)
                        }
                    }
                }
            }
        }
    }
    
    func addBlogBookmark(params: [String: Any], completion: @escaping (Int?) -> Void) {
        APIRequest.shared.getRequest(url: APIEndpoints.BLOG, parameters: params) { (JSON, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        MakeToast.shared.makeNormalToast(json["message"].stringValue)
                        if json["error"].boolValue == false {
                            let bookmark_id = json["blogUserBookmark"]["id"].int
                            completion(bookmark_id)
                        }
                    }
                }
            }
        }
    }
    
    func removeBlogBookmark(params: [String: Any], completion: @escaping (Bool) -> Void) {
        APIRequest.shared.getRequest(url: APIEndpoints.BLOG, parameters: params) { (JSON, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        MakeToast.shared.makeNormalToast(json["message"].stringValue)
                        if json["error"].boolValue == false {
                            completion(true)
                        }
                    }
                }
            }
        }
    }
    
}
