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
    
    func getHelpData(completion: @escaping (Help?) -> Void) {
        APIRequest.shared.getRequest(url: APIEndpoints.HELP_DATA, parameters:  nil) { (JSON, error) in
            DispatchQueue.main.async {
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
    
    func getDuePayment(params: [String: Any], completion: @escaping ([DueFees]) -> Void) {
        APIRequest.shared.getRequest(url: APIEndpoints.DUE_FEES, parameters:  params) { (JSON, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            completion(json["student_data"]["fees_heads"].arrayValue.map({ DueFees($0) }))
                        } else {
                            completion([])
                            MakeToast.shared.makeNormalToast(json["message"].stringValue)
                        }
                    }
                }
            }
        }
    }
    
    func getPaidPayment(page: Int, params: [String: Any], completion: @escaping ([Invoice], Int, Int) -> Void) {
        APIRequest.shared.getRequest(url: APIEndpoints.PAID_FEES+"\(page)", parameters:  params) { (JSON, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            let invoices = json["invoices"]["data"].arrayValue.map { Invoice($0) }
                            let currentPage = json["invoices"]["current_page"].intValue
                            let lastPage = json["invoices"]["last_page"].intValue
                            completion(invoices, currentPage, lastPage)
                        } else {
                            MakeToast.shared.makeNormalToast(json["message"].stringValue)
                        }
                    }
                }
            }
        }
    }
    
    func getInvoice(params: [String: Any], completion: @escaping (String) -> Void) {
        APIRequest.shared.getRequest(url: APIEndpoints.INVOICE, parameters:  params) { (JSON, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let json = JSON {
                        if json["error"].boolValue == false {
                            let invoice = json["print_html"].stringValue
                            completion(invoice)
                        } else {
                            MakeToast.shared.makeNormalToast(json["message"].stringValue)
                        }
                    }
                }
            }
        }
    }
    
}
