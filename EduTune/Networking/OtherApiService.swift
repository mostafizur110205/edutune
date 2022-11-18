//
//  OtherApiService.swift
//  EduTune
//
//  Created by Machtonis on 11/18/22.
//

import Foundation

extension APIService {
    
    func getReferrals(params: [String: Any], completion: @escaping (Referral?) -> Void) {
        APIRequest.shared.getRequest(url: APIEndpoints.MY_POINT_DASHBOARD, parameters: params) { (JSON, error) in
            DispatchQueue.main.async {
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
}
