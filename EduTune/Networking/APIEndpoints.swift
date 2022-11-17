//
//  Endpoints.swift
//  KiezaYetuNew
//
//  Created by Ahnaf Rahat on 10/4/20.
//  Copyright © 2020 Mohaimin Fahad. All rights reserved.
//

import UIKit

open class APIEndpoints: NSObject {
    
    public static let ACCESS_TOKEN: String = "8oH-ja7he957KSqViw3adw_8UALqe0ClLUmd4Oio8U6BGGk6SfvRJB4GJWH2AAApAd8dBw:APA91bFA0JJ-1TOmMfL3-eoOaKvHfh-vuPgIIDTxBq7_FA0JJ-1TOmMfcwdwou38"
    public static let S3_URL: String = "https://amadereshkul.s3-ap-southeast-1.amazonaws.com/4394ac/"

    public static let BASE_URL: String = "https://amadereshkul.com/mobile-app/"

    public static let APP_VERSION: String = BASE_URL+"app-versions"
    
    public static let ONBOARD_DATA: String = BASE_URL+"get-mobile-app"
    public static let AUTH1: String = BASE_URL+"online-class-registration-and-login-step1"
    public static let AUTH2: String = BASE_URL+"online-class-registration-and-login-step2"
    public static let RELOGIN: String = BASE_URL+"online-class-login-inst-check"
    
    public static let HOME_PUBLIC: String = BASE_URL+"olv2/public/home"
    public static let SEE_ALL: String = BASE_URL+"olv2/see-all?page="
    public static let COURSE_DETAIL: String = BASE_URL+"olv2/public/online-course-details"
    public static let MENTOR_DETAIL: String = BASE_URL+"olv2/mentor-details?page="
    
    public static let BOOKMARKS: String = BASE_URL+"olv2/class-user-bookmark"
    public static let NOTIFICATIONS: String = BASE_URL+"push/log"

    public static let BLOG: String = BASE_URL+"olv2/public/blog"

    public static let MY_COURSE: String = BASE_URL+"olv2/my-course"
    public static let APPLY_COUPON: String = BASE_URL+"get-class-coupon-data"
    public static let COURSE_PURCHASE: String = BASE_URL+"online-class-payment-complete"
    
}
