//
//  HomeAPIService.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 16/11/22.
//

import UIKit
import SwiftyJSON
import SVProgressHUD

extension APIService {

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

}
