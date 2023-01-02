//
//  APIService.swift
//  BoomSoccer
//
//  Created by Mostafizur Rahman on 11/9/20.
//  Copyright © 2020 PEEMZ. All rights reserved.
//

import UIKit
import SwiftyJSON

class APIService: NSObject {
    
    static let shared = APIService()
        
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
    
}
