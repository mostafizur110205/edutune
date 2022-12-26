//
//  UserAPIService.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 16/11/22.
//

import UIKit
import SwiftyJSON

extension APIService {

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
                            let default_goal_list = json["default_goal_list"].arrayValue.map { UserGoal($0) }
                            let goal = default_goal_list.first(where: { $0.id == json["goal_class_id"].int })
                            user.goal = goal
                            user.group = goal?.group.first(where: { $0.id == json["goal_group_id"].int })
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
    
    
    func updateProfileImage(params: [String: Any], completion: @escaping (String) -> Void) {
        APIRequest.shared.postRequestJSON(url: APIEndpoints.UPDATE_PROFILE_IMAGE, parameters: params) { (JSON, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            completion(json["photo"].stringValue)
                        } else {
                            MakeToast.shared.makeNormalToast(json["message"].stringValue)
                        }
                    }
                }
            }
        }
    }


}
