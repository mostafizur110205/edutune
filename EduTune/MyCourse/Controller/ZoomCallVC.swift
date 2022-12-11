//
//  ZoomCallVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 7/12/22.
//

import UIKit
import MobileRTC

class ZoomCallVC: UIViewController {
        @IBOutlet weak var statusLabel: UILabel!

    var host_link: String?
    var host_name: String?
    var zoom_sdk_app_key: String?
    var zoom_sdk_app_secret: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                host_link = "https://us04web.zoom.us/j/72847824469?pwd=u1sHOPpSTUEjsta1uwuc9bMLuvYg4U.1"

        // The Zoom SDK requires a UINavigationController to update the UI for us. Here we supplied the SDK with the ViewControllers navigationController.
        MobileRTC.shared().setMobileRTCRootController(self.navigationController)
        
        /// Notification that is used to start a meeting upon log in success.
        NotificationCenter.default.addObserver(self, selector: #selector(userLoggedIn), name: NSNotification.Name(rawValue: "userLoggedIn"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SDKInitialized), name: NSNotification.Name(rawValue: "SDKInitialized"), object: nil)
        
    }
    
    @objc func userLoggedIn() {
        startMeeting()
    }
    
    @objc func SDKInitialized() {
        let components = (host_link ?? "").components(separatedBy: "?pwd=")
        let meetingNumber = components[0].components(separatedBy: "/").last ?? ""
        let password = components[1]
        
        joinMeeting(meetingNumber: meetingNumber, meetingPassword: password)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AppDelegate.shared().setupSDK(sdkKey: zoom_sdk_app_key ?? "", sdkSecret: zoom_sdk_app_secret ?? "")
    }
    
    // MARK: - IBOutlets
    
    func joinMeeting(meetingNumber: String, meetingPassword: String) {
        // Obtain the MobileRTCMeetingService from the Zoom SDK, this service can start meetings, join meetings, leave meetings, etc.
        MobileRTC.shared().getMeetingSettings()?.meetingInviteHidden = true
        MobileRTC.shared().getMeetingSettings()?.meetingPasswordHidden = true
        MobileRTC.shared().getMeetingSettings()?.topBarHidden = true

        if let meetingService = MobileRTC.shared().getMeetingService() {
            
            // Set the ViewController to be the MobileRTCMeetingServiceDelegate
            meetingService.delegate = self
            
            // Create a MobileRTCMeetingJoinParam to provide the MobileRTCMeetingService with the necessary info to join a meeting.
            // In this case, we will only need to provide a meeting number and password.
            let joinMeetingParameters = MobileRTCMeetingJoinParam()
            joinMeetingParameters.meetingNumber = meetingNumber
            joinMeetingParameters.password = meetingPassword
            joinMeetingParameters.noVideo = true
            joinMeetingParameters.noAudio = true

            // Call the joinMeeting function in MobileRTCMeetingService. The Zoom SDK will handle the UI for you, unless told otherwise.
            // If the meeting number and meeting password are valid, the user will be put into the meeting. A waiting room UI will be presented or the meeting UI will be presented.
            meetingService.joinMeeting(with: joinMeetingParameters)
        }
    }
    
    ///   - User has logged into Zoom successfully.
    func startMeeting() {
        // Obtain the MobileRTCMeetingService from the Zoom SDK, this service can start meetings, join meetings, leave meetings, etc.
        if let meetingService = MobileRTC.shared().getMeetingService() {
            // Set the ViewController to be the MobileRTCMeetingServiceDelegate
            meetingService.delegate = self
            
            // Create a MobileRTCMeetingStartParam to provide the MobileRTCMeetingService with the necessary info to start an instant meeting.
            // In this case we will use MobileRTCMeetingStartParam4LoginlUser(), since the user has logged into Zoom.
            let startMeetingParameters = MobileRTCMeetingStartParam4LoginlUser()
            
            // Call the startMeeting function in MobileRTCMeetingService. The Zoom SDK will handle the UI for you, unless told otherwise.
            meetingService.startMeeting(with: startMeetingParameters)
        }
    }
    
}

extension ZoomCallVC: MobileRTCMeetingServiceDelegate {
    
    // Is called upon in-meeting errors, join meeting errors, start meeting errors, meeting connection errors, etc.
    func onMeetingError(_ error: MobileRTCMeetError, message: String?) {
        switch error {
        case .success:
            print("Successful meeting operation.")
        case .passwordError:
            print("Could not join or start meeting because the meeting password was incorrect.")
        default:
            print("MobileRTCMeetError: \(error) \(message ?? "")")
        }
    }
    
    // Is called when the user joins a meeting.
    func onJoinMeetingConfirmed() {
        print("Join meeting confirmed.")
    }
    
    // Is called upon meeting state changes.
    func onMeetingStateChange(_ state: MobileRTCMeetingState) {
        print("Current meeting state: \(state)")
    }
}


//class ZoomCallVC: UIViewController {
//
//    @IBOutlet weak var statusLabel: UILabel!
//
//    var host_link: String?
//    var host_name: String?
//    var zoom_sdk_app_key: String?
//    var zoom_sdk_app_secret: String?
//
//    lazy var customMeetingUIViewController: CustomMeetingUIViewController = {
//        let vc = CustomMeetingUIViewController()
//        vc.delegate = self
//        return vc
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        host_link = "https://us04web.zoom.us/j/76917594799?pwd=GMuZagCJaKTjHwsHrVt6jwKPQHs9dX.1"
//
//        NotificationCenter.default.addObserver(self, selector: #selector(userLoggedIn), name: NSNotification.Name(rawValue: "userLoggedIn"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(SDKInitialized), name: NSNotification.Name(rawValue: "SDKInitialized"), object: nil)
//
//        //        let sdkInitContext = MobileRTCSDKInitContext()
//        //                sdkInitContext.appGroupId = ""
//        //                sdkInitContext.domain = "https://zoom.us"
//        //                sdkInitContext.enableLog = true
//        //
//        //                if MobileRTC.shared().initialize(sdkInitContext) {
//        //                    if let authService = MobileRTC.shared().getAuthService() {
//        //                        authService.delegate = self
//        //
//        //                        authService.jwtToken = ""
//        //
//        //                        authService.sdkAuth()
//        //                    }
//        //                }
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        AppDelegate.shared().setupSDK(sdkKey: zoom_sdk_app_key ?? "", sdkSecret: zoom_sdk_app_secret ?? "")
//
//    }
//
//    @objc func userLoggedIn() {
//        startMeeting()
//    }
//
//    @objc func SDKInitialized() {
//        MobileRTC.shared().setMobileRTCRootController(self.navigationController)
//        MobileRTC.shared().getMeetingSettings()?.enableCustomMeeting = true
//
//        let components = (host_link ?? "").components(separatedBy: "?pwd=")
//        let meetingNumber = components[0].components(separatedBy: "/").last ?? ""
//        let password = components[1]
//
//        joinMeeting(meetingNumber: meetingNumber, meetingPassword: password)
//    }
//
//}
//
//extension ZoomCallVC: CustomMeetingUIViewControllerDelegate {
//
//    func userWasAdmittedFromTheWaitingRoom() {
//        DispatchQueue.main.async { [weak self] in
//            if let strongSelf = self {
//                strongSelf.customMeetingUIViewController.modalPresentationStyle = .fullScreen
//                strongSelf.present(strongSelf.customMeetingUIViewController, animated: true, completion: nil)
//            }
//        }
//    }
//}
//
//
//extension ZoomCallVC: MobileRTCMeetingServiceDelegate, MobileRTCCustomizedUIMeetingDelegate  {
//    func onInitMeetingView() {
//        print("onInitMeetingView")
//
//    }
//
//    func onDestroyMeetingView() {
//        print("onDestroyMeetingView")
//    }
//
//
//    func joinMeeting(meetingNumber: String, meetingPassword: String) {
//
//        guard let meetingService = MobileRTC.shared().getMeetingService(),
//              let meetingSettings = MobileRTC.shared().getMeetingSettings() else { return }
//
//        meetingService.delegate = customMeetingUIViewController
//        meetingService.customizedUImeetingDelegate = self
//
//        meetingSettings.enableCustomMeeting = true
//
//        let joinParams = MobileRTCMeetingJoinParam()
//        joinParams.meetingNumber = meetingNumber
//        joinParams.password = meetingPassword
//        joinParams.userName = AppDelegate.shared().user?.username ?? "user"
//        joinParams.noAudio = false
//        joinParams.noVideo = false
//        let joinMeetingReturnValue = meetingService.joinMeeting(with: joinParams)
//
//        switch joinMeetingReturnValue {
//        case .success:
//            print("Joining meeting.")
//        case .inAnotherMeeting:
//            print("User is in another meeting.")
//            showAlert(with: "User is in another meeting.")
//        default:
//            print("Error joining meeting: \(joinMeetingReturnValue.rawValue)")
//        }
//
//        //        // Obtain the MobileRTCMeetingService from the Zoom SDK, this service can start meetings, join meetings, leave meetings, etc.
//        //        if let meetingService = MobileRTC.shared().getMeetingService() {
//        //
//        //            // Set the ViewController to be the MobileRTCMeetingServiceDelegate
//        //            meetingService.delegate = self
//        //            meetingService.customizedUImeetingDelegate = self
//        //
//        //            // Create a MobileRTCMeetingJoinParam to provide the MobileRTCMeetingService with the necessary info to join a meeting.
//        //            // In this case, we will only need to provide a meeting number and password.
//        //            let joinMeetingParameters = MobileRTCMeetingJoinParam()
//        //            joinMeetingParameters.meetingNumber = meetingNumber
//        //            joinMeetingParameters.password = meetingPassword
//        //            joinMeetingParameters.userName = AppDelegate.shared().user?.username ?? "user"
//        //            joinMeetingParameters.noAudio = true
//        //            joinMeetingParameters.noVideo = true
//        //
//        //            // Call the joinMeeting function in MobileRTCMeetingService. The Zoom SDK will handle the UI for you, unless told otherwise.
//        //            // If the meeting number and meeting password are valid, the user will be put into the meeting. A waiting room UI will be presented or the meeting UI will be presented.
//        //            meetingService.joinMeeting(with: joinMeetingParameters)
//        //        }
//    }
//
//    func startMeeting() {
//        // Obtain the MobileRTCMeetingService from the Zoom SDK, this service can start meetings, join meetings, leave meetings, etc.
//        if let meetingService = MobileRTC.shared().getMeetingService() {
//            // Set the ViewController to be the MobileRTCMeetingServiceDelegate
//            meetingService.delegate = self
//
//            // Create a MobileRTCMeetingStartParam to provide the MobileRTCMeetingService with the necessary info to start an instant meeting.
//            // In this case we will use MobileRTCMeetingStartParam4LoginlUser(), since the user has logged into Zoom.
//            let startMeetingParameters = MobileRTCMeetingStartParam4LoginlUser()
//
//            // Call the startMeeting function in MobileRTCMeetingService. The Zoom SDK will handle the UI for you, unless told otherwise.
//            meetingService.startMeeting(with: startMeetingParameters)
//        }
//    }
//
//
//    // Is called upon in-meeting errors, join meeting errors, start meeting errors, meeting connection errors, etc.
//    func onMeetingError(_ error: MobileRTCMeetError, message: String?) {
//        switch error {
//        case .success:
//            print("Successful meeting operation.")
//        case .passwordError:
//            print("Could not join or start meeting because the meeting password was incorrect.")
//        default:
//            print("MobileRTCMeetError: \(error) \(message ?? "")")
//        }
//    }
//
//    // Is called when the user joins a meeting.
//    func onJoinMeetingConfirmed() {
//        print("Join meeting confirmed.")
//    }
//
//    // Is called upon meeting state changes.
//    func onMeetingStateChange(_ state: MobileRTCMeetingState) {
//        print("Current meeting state: \(state)")
//    }
//}
//
//extension UIViewController {
//
//    func showAlert(with title: String, and message: String? = nil, action: UIAlertAction? = nil) {
//        DispatchQueue.main.async {
//            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//
//            if let action = action {
//                alertController.addAction(action)
//            }
//
//            let keyWindow = UIApplication.shared.connectedScenes
//                .filter({$0.activationState == .foregroundActive})
//                .compactMap({$0 as? UIWindowScene})
//                .first?.windows
//                .filter({$0.isKeyWindow}).first
//            var rootViewController = keyWindow?.rootViewController
//            if let navigationController = rootViewController as? UINavigationController {
//                rootViewController = navigationController.viewControllers.first
//            }
//
//
//            rootViewController?.present(alertController, animated: true, completion: nil)
//        }
//    }
//}
