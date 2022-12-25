//
//  OtherApiService.swift
//  EduTune
//
//  Created by Machtonis on 11/18/22.
//

import Foundation
import SVProgressHUD

extension APIService {
    
    func getReferrals(params: [String: Any], completion: @escaping (Referral?) -> Void) {
        APIRequest.shared.getRequest(url: APIEndpoints.MY_POINT_DASHBOARD, parameters: params) { (JSON, error) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            completion(Referral(json))
                        } else {
                            completion(nil)
                            MakeToast.shared.makeNormalToast(json["message"].stringValue)
                        }
                    }
                }
            }
        }
    }
    
    func getHelpData(completion: @escaping (Help?) -> Void) {
        APIRequest.shared.getRequest(url: APIEndpoints.HELP_DATA, parameters:  nil) { (JSON, error) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            completion(Help(json["data"]))
                        } else {
                            completion(nil)
                            MakeToast.shared.makeNormalToast(json["message"].stringValue)
                        }
                    }
                }
            }
        }
    }
    
    func getMyCertificates(params: [String: Any], completion: @escaping ([Certificate]) -> Void) {
        APIRequest.shared.getRequest(url: APIEndpoints.MY_CERTIFICATES, parameters:  params) { (JSON, error) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            completion(json["data"].arrayValue.map({ Certificate($0) }))
                        } else {
                            completion([])
                            MakeToast.shared.makeNormalToast(json["message"].stringValue)
                        }
                    }
                }
            }
        }
    }
    
}
