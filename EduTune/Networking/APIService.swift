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
    
    func getHomeData(completion: @escaping (HomeData?) -> Void) {
        APIRequest.shared.getRequest(url: APIEndpoints.HOME_PUBLIC, parameters: nil) { (JSON, error) in
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
