//
//  ApiRequest.swift
//  BOOM SOCCER
//
//  Created by Mostafizur Rahman on 26/5/20.
//  Copyright © 2020 PEEMZ. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIRequest: NSObject {
    
    static let shared = APIRequest()
    
    let networkQueue = DispatchQueue(label: "com.edutune.api", qos: .background, attributes: .concurrent)
    
    static private var header: HTTPHeaders {
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": AppUserDefault.getToken() ?? ""
        ]
        return header
    }
    
    public func getRequest(url: String, parameters: [String: Any]?, completion: @escaping (_ JSON: JSON?, _ error: NSError?) -> Void) {
        
        var parameters = parameters ?? [String: Any]()
        parameters["user_type"] = 2
        parameters["institution_url"] = "https://edutune.com"
        parameters["institution_id"] = 206
        
        print(parameters)

        let escapedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? url
        
        AF.request(URL(string: escapedString)!, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: APIRequest.header, interceptor: nil).responseJSON(queue: self.networkQueue, completionHandler: {
            response in
            
            let statusCode: Int = response.response?.statusCode ?? -1
            let requestURL: String = response.request?.url?.absoluteString ?? "No url"
            print("\(statusCode) -- \(requestURL)")
            print(response)
            
            //            if statusCode == 401 {
            //                SocketClient.shared.logout()
            //            }
            
            switch response.result {
            case .success(let value):
                //                print(value)
                let json = JSON(value)
                completion(json, nil)
            case .failure(let error):
                completion(nil, error as NSError)
            }
        })
    }
    
    public func postRequest(url: String, parameters: [String: Any]?, completion: @escaping (_ JSON: JSON?, _ error: NSError?) -> Void) {
        
        var parameters = parameters ?? [String: Any]()
        parameters["user_type"] = 2
        parameters["institution_url"] = "https://edutune.com"
        parameters["institution_id"] = 206
        
        print(parameters)
        
        let escapedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? url
        
        AF.request(URL(string: escapedString)!, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: APIRequest.header, interceptor: nil).responseJSON(queue: self.networkQueue, completionHandler: {
            response in
            
            let statusCode: Int = response.response?.statusCode ?? -1
            let requestURL: String = response.request?.url?.absoluteString ?? "No url"
            print("\(statusCode) -- \(requestURL)")
            print(response)
            
            //            if statusCode == 401 {
            //                SocketClient.shared.logout()
            //            }
            
            switch response.result {
            case .success(let value):
                //                print(value)
                let json = JSON(value)
                completion(json, nil)
            case .failure(let error):
                completion(nil, error as NSError)
            }
            
        })
    }
    
    public func postRequestJSON(url: String, parameters: [String: Any]?, completion: @escaping (_ JSON: JSON?, _ error: NSError?) -> Void) {
        
        var parameters = parameters ?? [String: Any]()
        parameters["user_type"] = 2
        parameters["institution_url"] = "https://edutune.com"
        parameters["institution_id"] = 206
        
        print(parameters)

        let escapedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? url
        
        AF.request(URL(string: escapedString)!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: APIRequest.header, interceptor: nil).responseJSON(queue: self.networkQueue, completionHandler: {
            response in
            
            let statusCode: Int = response.response?.statusCode ?? -1
            let requestURL: String = response.request?.url?.absoluteString ?? "No url"
            print("\(statusCode) -- \(requestURL)")
            print(response)
            
            //            if statusCode == 401 {
            //                SocketClient.shared.logout()
            //            }
            
            switch response.result {
            case .success(let value):
                //                print(value)
                let json = JSON(value)
                completion(json, nil)
            case .failure(let error):
                completion(nil, error as NSError)
            }
            
        })
    }
    
    //    public func uploadImage (url: String, name: String, method: HTTPMethod = .post , image: UIImage, params: Parameters = [:], completion: @escaping (_ JSON: JSON?, _ error: NSError?) -> Void) {
    //
    //        var parameters = parameters ?? [String: Any]()
    //        parameters["user_type"] = 2
    //        parameters["institution_url"] = "https://edutune.com"
    //        parameters["institution_id"] = 206
    //
    //        let escapedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? url
    //
    //        if let URL = try? URLRequest(url: escapedString, method: method, headers: APIRequest.header) {
    //            let imgData = image.pngData()
    //
    //            AF.upload(multipartFormData: { (multipartFormData) in
    //                for (key, value) in params {
    //                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
    //                }
    //                multipartFormData.append(imgData!, withName: name, fileName: "\(name).png", mimeType: "image/png")
    //
    //            }, with: URL).responseJSON { (response) in
    //
    //                print(response)
    //
    //                switch response.result {
    //                case .success(let value):
    //                    //                print(value)
    //                    let json = JSON(value)
    //                    completion(json, nil)
    //                case .failure(let error):
    //                    completion(nil, error as NSError)
    //                }
    //            }
    //        }
    //
    //    }
}
