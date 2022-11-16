//
//  MyCourseAPiService.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 16/11/22.
//

import UIKit
import SwiftyJSON
import SVProgressHUD

extension APIService {

    func getMyCourse(params: [String: Any], completion: @escaping ([LiveClass]?, [DueAssignments]?,  [OngoingClass]?) -> Void) {
        APIRequest.shared.getRequest(url: APIEndpoints.MY_COURSE, parameters: params) { (JSON, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            let liveClass = json["allClass"].arrayValue.map { LiveClass($0) }
                            let dueAssignments = json["running_assignments"].arrayValue.map { DueAssignments($0) }
                            let onGoingClass = json["registered_classes"].arrayValue.map { OngoingClass($0) }
                            
                            completion(liveClass, dueAssignments, onGoingClass)
                        }
                    }
                }
            }
        }
    }
    
    func applyPromo(params: [String: Any], completion: @escaping (Coupon?) -> Void) {
        APIRequest.shared.postRequestJSON(url: APIEndpoints.APPLY_COUPON, parameters: params) { (JSON, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            completion(Coupon(json: json))
                        } else {
                            completion(nil)
                            MakeToast.shared.makeNormalToast(json["message"].stringValue)
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
                            MakeToast.shared.makeNormalToast(json["message"].stringValue)
                        } else {
                            MakeToast.shared.makeNormalToast(json["message"].stringValue)
                        }
                    }
                }
            }
        }
    }

}
