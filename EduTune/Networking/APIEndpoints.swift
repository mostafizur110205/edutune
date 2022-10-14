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
    public static let HOME_PUBLIC: String = BASE_URL+"olv2/public/home"
    public static let SEE_ALL: String = BASE_URL+"olv2/see-all?page="
    
}
