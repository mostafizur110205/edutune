//
//  AppDelegate.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 19/9/22.
//

import UIKit
import SVProgressHUD
import IQKeyboardManagerSwift

let GOOGLECLIENTID = "606879515005-8ie3fedl108c6vrdg4mko9keqg96bppi.apps.googleusercontent.com"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var uuid: String?

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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setDefaultStyle(.light)
        IQKeyboardManager.shared.enable = true

        return true
    }
    
    func openMentorProfileVC(navigationController: UINavigationController?, mentor: Teacher) {
        if let viewC: MentorProfileVC = UIStoryboard(name: "Course", bundle: nil).instantiateViewController(withIdentifier: "MentorProfileVC") as? MentorProfileVC {
            viewC.teacher_id = mentor.id
            navigationController?.pushViewController(viewC, animated: true)
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

