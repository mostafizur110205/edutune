//
//  AppDelegate.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 19/9/22.
//

import UIKit
import SVProgressHUD
import IQKeyboardManagerSwift
import MobileRTC

let MODEL_TEST_TYPE = 8
let QUIZ_TYPE = 10
let ASSESSMENT_TYPE = 11

let VIDEO_TYPE = 1

let LIVE_TYPE = 2
let AUDIO_BOOK_TYPE = 3
let TRANSCRIPT_TYPE = 4
let NOTE_TYPE = 5
let PDF_BOOK_TYPE = 6
let LECTURE_SHEET_TYPE = 7
let SOLVE_CLASS_TYPE = 9
let GOOGLECLIENTID = "606879515005-8ie3fedl108c6vrdg4mko9keqg96bppi.apps.googleusercontent.com"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var uuid: String?
    var user: User? {
        didSet {
            if let token = user?.bearer_token {
                AppUserDefault.setToken("Bearer \(token)")
            }
            AppUserDefault.setUserId(user?.user_id ?? -1)
            AppUserDefault.setPicture(user?.photo ?? "")
            AppUserDefault.setName(user?.username ?? "")
            AppUserDefault.setPhone(user?.phone ?? "")
            AppUserDefault.setEmail(user?.email ?? "")
            AppUserDefault.setIsLoggedIn(true)
        }
    }
    
    var bookmarkIds = [Int]()

    var topInset: CGFloat {
        return window?.safeAreaInsets.top ?? 0
    }
    
    var bottomInset: CGFloat {
        return window?.safeAreaInsets.bottom ?? 0
    }
    
    class func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func registerRemoteNotification() {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func getDueDate(_ dateStringValue: String?) -> (String, Bool) {
        guard let dateString = dateStringValue else {return ("", false)}
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss";
        let date = dateFormatter.date(from: dateString) ?? Date()
        
        let isDuePassed = date>Date()
        dateFormatter.dateFormat = "d MMM, hh:mm a"
        return (dateFormatter.string(from: date), isDuePassed)
    }
    
    func openMentorProfileVC(navigationController: UINavigationController?, mentor: Teacher) {
        if let viewC: MentorProfileVC = UIStoryboard(name: "Course", bundle: nil).instantiateViewController(withIdentifier: "MentorProfileVC") as? MentorProfileVC {
            viewC.teacher_id = mentor.id
            navigationController?.pushViewController(viewC, animated: true)
        }
    }
    
    func checkAndShowLoginVC(navigationController: UINavigationController?) -> Bool {
        if AppUserDefault.getIsLoggedIn() {
            return true
        } else {
            if let viewC: LetsInVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "LetsInVC") as? LetsInVC {
                navigationController?.pushViewController(viewC, animated: true)
            }
            return false
        }
    }
    
    func getCategoryNameIcon(_ type: Int) -> (String, String) {
        switch type {
        case MODEL_TEST_TYPE, ASSESSMENT_TYPE:
            return ("Assignment", "ic_message")
        case QUIZ_TYPE:
            return ("Quiz", "ic_email_blue")
        case VIDEO_TYPE:
            return ("Video", "ic_play")
        case LIVE_TYPE:
            return ("Live", "ic_video")
        case AUDIO_BOOK_TYPE, TRANSCRIPT_TYPE, NOTE_TYPE, PDF_BOOK_TYPE, SOLVE_CLASS_TYPE:
            return ("Document", "ic_document")
        case LECTURE_SHEET_TYPE:
            return ("Lecture Sheet", "ic_download")
        case SOLVE_CLASS_TYPE:
            return ("Solve Class", "ic_star_blue")
        default:
            return ("", "")
        }
    }
    
    func formatPrice(_ current_price: Int?) -> String {
        let price = current_price ?? 0
        return price == 0 ? "Free" : "৳\(price)"
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setDefaultStyle(.light)
        IQKeyboardManager.shared.enable = true
        
        window?.overrideUserInterfaceStyle = .light
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        if let authorizationService = MobileRTC.shared().getAuthService() {

            // Call logoutRTC() to log the user out.
            authorizationService.logoutRTC()

            // Notify MobileRTC of appWillTerminate call.
            MobileRTC.shared().appWillTerminate()
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Notify MobileRTC of appWillResignActive call.
        MobileRTC.shared().appWillResignActive()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Notify MobileRTC of appDidBecomeActive call.
        MobileRTC.shared().appDidBecomeActive()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Notify MobileRTC of appDidEnterBackgroud call.
        MobileRTC.shared().appDidEnterBackgroud()
    }

    func setupSDK(sdkKey: String, sdkSecret: String) {
        // Create a MobileRTCSDKInitContext. This class contains attributes for modifying how the SDK will be created. You must supply the context with a domain.
        let context = MobileRTCSDKInitContext()
        // The domain we will use is zoom.us
        context.domain = "zoom.us"
        // Turns on SDK logging. This is optional.
        context.enableLog = true

        // Call initialize(_ context: MobileRTCSDKInitContext) to create an instance of the Zoom SDK. Without initializing first, the SDK will not do anything. This call will return true if the SDK was initialized successfully.
        let sdkInitializedSuccessfully = MobileRTC.shared().initialize(context)

        // Check if initialization was successful. Obtain a MobileRTCAuthService, this is for supplying credentials to the SDK for authorization.
        if sdkInitializedSuccessfully == true, let authorizationService = MobileRTC.shared().getAuthService() {

            // Supply the SDK with SDK Key and SDK Secret. This is required if a JWT is not supplied.
            // To use a JWT, replace these lines with authorizationService.jwtToken = yourJWTToken.
            authorizationService.clientKey = sdkKey
            authorizationService.clientSecret = sdkSecret

            // Assign AppDelegate to be a MobileRTCAuthDelegate to listen for authorization callbacks.
            authorizationService.delegate = self

            // Call sdkAuth to perform authorization.
            authorizationService.sdkAuth()
        }
    }


}

extension AppDelegate: MobileRTCAuthDelegate {

    // Result of calling sdkAuth(). MobileRTCAuthError_Success represents a successful authorization.
    func onMobileRTCAuthReturn(_ returnValue: MobileRTCAuthError) {
        switch returnValue {
        case .success:
            print("SDK successfully initialized.")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SDKInitialized"), object: nil)
        case .keyOrSecretEmpty:
            assertionFailure("SDK Key/Secret was not provided. Replace sdkKey and sdkSecret at the top of this file with your SDK Key/Secret.")
        case .keyOrSecretWrong, .unknown:
            assertionFailure("SDK Key/Secret is not valid.")
        default:
            assertionFailure("SDK Authorization failed with MobileRTCAuthError: \(returnValue).")
        }
    }
    
    // Result of calling logIn()
    func onMobileRTCLoginResult(_ resultValue: MobileRTCLoginFailReason) {
        switch resultValue {
        case .success:
            print("Successfully logged in")

            // This alerts the ViewController that log in was successful.
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userLoggedIn"), object: nil)
        case .wrongPassword:
            print("Password incorrect")
        default:
            print("Could not log in. Error code: \(resultValue)")

        }
    }

    // Result of calling logoutRTC(). 0 represents a successful log out attempt.
    func onMobileRTCLogoutReturn(_ returnValue: Int) {
        switch returnValue {
        case 0:
            print("Successfully logged out")
        default:
            print("Could not log out. Error code: \(returnValue)")
        }
    }
}
