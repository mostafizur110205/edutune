//
//  WordSearchUserDefault.swift
//  BOOM SOCCER
//
//  Created by Mostafizur Rahman on 26/5/20.
//  Copyright © 2020 PEEMZ. All rights reserved.

import Foundation

class AppUserDefault {
    
    class func getIsLoggedIn() -> Bool? {
        return UserDefaults.standard.bool(forKey: "is_logged_in")
    }
    
    class func setIsLoggedIn(_ flag: Bool) {
        UserDefaults.standard.set(flag, forKey: "is_logged_in")
        UserDefaults.standard.synchronize()
    }
    
    class func getIsAppOpened() -> Bool? {
        return UserDefaults.standard.bool(forKey: "is_app_opened")
    }
    
    class func setIsAppOpened(_ flag: Bool) {
        UserDefaults.standard.set(flag, forKey: "is_app_opened")
        UserDefaults.standard.synchronize()
    }
    
    class func getPushToken() -> String? {
        return UserDefaults.standard.string(forKey: "push_token")
    }
    
    class func setPushToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "push_token")
        UserDefaults.standard.synchronize()
    }
    
    class func getUserId() -> Int? {
        return UserDefaults.standard.integer(forKey: "user_id")
    }
    
    class func setUserId(_ userId: Int) {
        UserDefaults.standard.set(userId, forKey: "user_id")
        UserDefaults.standard.synchronize()
    }
    
    class func getPicture() -> String? {
        return UserDefaults.standard.string(forKey: "picture")
    }
    
    class func setPicture(_ picture: String) {
        UserDefaults.standard.set(picture, forKey: "picture")
        UserDefaults.standard.synchronize()
    }
    
    class func getToken() -> String? {
        return UserDefaults.standard.string(forKey: "token")
    }
    
    class func setToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "token")
        UserDefaults.standard.synchronize()
    }
    
    class func clearAll() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}
