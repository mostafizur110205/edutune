//
//  APIService.swift
//  BoomSoccer
//
//  Created by Mostafizur Rahman on 11/9/20.
//  Copyright © 2020 PEEMZ. All rights reserved.
//

import UIKit
import SwiftyJSON
import SVProgressHUD

class APIService: NSObject {
    
    static let shared = APIService()
    
//    func getAppVersionInfo(completion: @escaping (JSON) -> Void) {
//        APIRequest.shared.getRequest(url: APIEndpoints.APPVERSION, parameters: nil) { (JSON, error) in
//            DispatchQueue.main.async {
//                if error == nil {
//                    if let json = JSON {
//                        completion(json)
//                    }
//                }
//            }
//        }
//    }
    
    func signupStep1(params: [String: Any], completion: @escaping (String) -> Void) {
        APIRequest.shared.postRequestJSON(url: APIEndpoints.AUTH1, parameters: params) { (JSON, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            let token = json["token"].stringValue
                            completion(token)
                        } else {
                            MakeToast.shared.makeNormalToast(json["message"].stringValue)
                        }
                    }
                }
            }
        }
    }
    
    func signupStep2(params: [String: Any], completion: @escaping (User) -> Void) {
        APIRequest.shared.postRequestJSON(url: APIEndpoints.AUTH2, parameters: params) { (JSON, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            let user = User(json: json)
                            AppDelegate.shared().user = user
                            completion(user)
                        } else {
                            MakeToast.shared.makeNormalToast(json["message"].stringValue)
                        }
                    }
                }
            }
        }
    }
    
    func relogin(params: [String: Any], completion: @escaping (User) -> Void) {
        APIRequest.shared.postRequestJSON(url: APIEndpoints.RELOGIN, parameters: params) { (JSON, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            let user = User(json: json)
                            AppDelegate.shared().user = user
                            completion(user)
                        } else {
                            MakeToast.shared.makeNormalToast(json["message"].stringValue)
                        }
                    }
                }
            }
        }
    }
    
    func getOnboardData(completion: @escaping ([OnboardData]) -> Void) {
        let parameters = ["access_token": APIEndpoints.ACCESS_TOKEN, "package_id": "com.aitl.edutune"]

        APIRequest.shared.getRequest(url: APIEndpoints.ONBOARD_DATA, parameters: parameters) { (JSON, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            AppDelegate.shared().uuid = json["uuid"].string
                            let info = json["app_splash"].arrayValue.map { OnboardData(json: $0) }
                            completion(info)
                        }
                    }
                }
            }
        }
    }
    
    func getHomeData(params: [String: Any], completion: @escaping (HomeData?) -> Void) {
        APIRequest.shared.getRequest(url: APIEndpoints.HOME_PUBLIC, parameters: params) { (JSON, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            let info = HomeData(json: json["data"])
                            completion(info)
                        }
                    }
                }
            }
        }
    }
    
    func getTopEducators(params: [String: Any], completion: @escaping ([Teacher]) -> Void) {
        APIRequest.shared.getRequest(url: APIEndpoints.SEE_ALL, parameters: params) { (JSON, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            let teachers = json["data"]["top_educators"]["data"].arrayValue.map { Teacher(json: $0) }
                            completion(teachers)
                        }
                    }
                }
            }
        }
    }
    
    func getMostPopular(page: Int, params: [String: Any], completion: @escaping ([Class], [Program], Int, Int) -> Void) {
        APIRequest.shared.getRequest(url: APIEndpoints.SEE_ALL+"\(page)", parameters: params) { (JSON, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            let courses = json["data"]["most_popular_courses"]["data"].arrayValue.map { Class(json: $0) }
                            let programs = json["data"]["programs"].arrayValue.map { Program(json: $0) }
                            let currentPage = json["data"]["most_popular_courses"]["current_page"].intValue
                            let lastPage = json["data"]["most_popular_courses"]["last_page"].intValue
                            completion(courses, programs, currentPage, lastPage)
                        }
                    }
                }
            }
        }
    }
    
    func getCourseDetails(params: [String: Any], completion: @escaping (ClassDetail) -> Void) {
        APIRequest.shared.getRequest(url: APIEndpoints.COURSE_DETAIL, parameters: params) { (JSON, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            let classDetail = ClassDetail(json: json["class"])
                            let teachers = json["teachers"].arrayValue.map { Teacher(json: $0) }
                            classDetail.teachers = teachers
                            completion(classDetail)
                        }
                    }
                }
            }
        }
    }
    
    func getMentorDetails(page: Int, params: [String: Any], completion: @escaping (Teacher, [Class], Int, Int) -> Void) {
        APIRequest.shared.getRequest(url: APIEndpoints.MENTOR_DETAIL+"\(page)", parameters: params) { (JSON, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            let teacher = Teacher(json: json["teacher_details"])
                            teacher.class_count = json["teacher_courses"]["total"].intValue
                            let classes = json["teacher_courses"]["data"].arrayValue.map { Class(json: $0) }
                            let currentPage = json["teacher_courses"]["current_page"].intValue
                            let lastPage = json["teacher_courses"]["last_page"].intValue

                            completion(teacher, classes, currentPage, lastPage)
                        }
                    }
                }
            }
        }
    }
    
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
    
    func getMyCourse(page: Int, params: [String: Any], completion: @escaping ([Blog], [BlogType], Int, Int) -> Void) {
        APIRequest.shared.getRequest(url: APIEndpoints.MY_COURSE, parameters: params) { (JSON, error) in
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
    
    func purchaseCourse(params: [String: Any], completion: @escaping (Bool) -> Void) {
        APIRequest.shared.postRequestJSON(url: APIEndpoints.COURSE_PURCHASE, parameters: params) { (JSON, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            completion(true)
                        }
                    }
                }
            }
        }
    }
    
//    func getSearchResult(_ queryText: String, completion: @escaping ([User], [Trend]) -> Void) {
//        APIRequest.shared.getRequest(url: APIEndpoints.SEARCH+"\(queryText)", parameters: nil) { (JSON, error) in
//            DispatchQueue.main.async {
//                if error == nil {
//                    if let json = JSON {
//                        if json["success"].boolValue == true {
//                            let users = json["data"]["users"].arrayValue.map { (User(json: $0)) }.sorted(by: { $0.fullname ?? "" < $1.fullname ?? "" })
//                            let posts = json["data"]["trends"].arrayValue.map { (Trend(json: $0)) }.sorted(by: { $0.title ?? "" < $1.title ?? "" })
//
//                            completion(users, posts)
//                        }
//                    }
//                }
//            }
//        }
//    }
    
}
