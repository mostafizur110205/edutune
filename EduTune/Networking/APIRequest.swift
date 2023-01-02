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
import SVProgressHUD

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
        
        SVProgressHUD.show()
        
        AF.request(URL(string: escapedString)!, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: APIRequest.header, interceptor: nil).responseDecodable(of: JSON.self, queue: self.networkQueue) {
            response in
            
            let statusCode: Int = response.response?.statusCode ?? -1
            let requestURL: String = response.request?.url?.absoluteString ?? "No url"
            print("\(statusCode) -- \(requestURL)")
            print(response)
            SVProgressHUD.dismiss()
            
            switch response.result {
            case .success(let value):
                completion(value, nil)
            case .failure(let error):
                completion(nil, error as NSError)
            }
        }
    }
    
    public func postRequest(url: String, parameters: [String: Any]?, completion: @escaping (_ JSON: JSON?, _ error: NSError?) -> Void) {
        
        var parameters = parameters ?? [String: Any]()
        parameters["user_type"] = 2
        parameters["institution_url"] = "https://edutune.com"
        parameters["institution_id"] = 206
        
        print(parameters)
        
        let escapedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? url
        
        SVProgressHUD.show()
        AF.request(URL(string: escapedString)!, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: APIRequest.header, interceptor: nil).responseDecodable(of: JSON.self, queue: self.networkQueue) {
            response in
            
            let statusCode: Int = response.response?.statusCode ?? -1
            let requestURL: String = response.request?.url?.absoluteString ?? "No url"
            print("\(statusCode) -- \(requestURL)")
            print(response)
            SVProgressHUD.dismiss()
            
            switch response.result {
            case .success(let value):
                completion(value, nil)
            case .failure(let error):
                completion(nil, error as NSError)
            }
        }
    }
    
    public func postRequestJSON(url: String, parameters: [String: Any]?, completion: @escaping (_ JSON: JSON?, _ error: NSError?) -> Void) {
        
        var parameters = parameters ?? [String: Any]()
        parameters["user_type"] = 2
        parameters["institution_url"] = "https://edutune.com"
        parameters["institution_id"] = 206
        
        print(parameters)
        
        let escapedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? url
        
        SVProgressHUD.show()
        AF.request(URL(string: escapedString)!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: APIRequest.header, interceptor: nil).responseDecodable(of: JSON.self, queue: self.networkQueue) {
            response in
            
            let statusCode: Int = response.response?.statusCode ?? -1
            let requestURL: String = response.request?.url?.absoluteString ?? "No url"
            print("\(statusCode) -- \(requestURL)")
            print(response)
            SVProgressHUD.dismiss()
            
            switch response.result {
            case .success(let value):
                completion(value, nil)
            case .failure(let error):
                completion(nil, error as NSError)
            }
        }
    }
    
    public func uploadImage(url: String, image:UIImage, parameters: [String: Any]?, completion: @escaping (_ JSON: JSON?, _ error: NSError?) -> Void) {
        
        var params = parameters ?? [String: Any]()
        params["user_type"] = 2
        params["institution_url"] = "https://edutune.com"
        params["institution_id"] = 206
        
        let parameterS: Parameters = params
        
        AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in parameterS {
                    if let temp = value as? String {
                        multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                    }
                    if let temp = value as? Int {
                        multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                    }
                    if let temp = value as? NSArray {
                        temp.forEach({ element in
                            let keyObj = key + "[]"
                            if let string = element as? String {
                                multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                            } else
                            if let num = element as? Int {
                                let value = "\(num)"
                                multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                            }
                        })
                    }
                }
                multipartFormData.append(image.jpegData(compressionQuality: 0.3)!, withName: "image" , fileName: "file.jpeg", mimeType: "image/jpeg")
            },
            to: url, method: .post , headers: APIRequest.header)
        .validate(statusCode: 200..<300)
        .response { response in
            switch response.result {
            case .success(let value):
                guard let json = (try? JSON(data: value!)) else {completion(nil,nil); return}
                print("********** File Uploaded *************")
                completion(json, nil)
            case .failure(let error):
                completion(nil, error as NSError)
            }
        }
    }
    

}
