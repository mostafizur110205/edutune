//
//  CustomUIViewController.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 7/12/22.
//

import Foundation
import MobileRTC

protocol CustomMeetingUIViewControllerDelegate: NSObject {
    
    func userWasAdmittedFromTheWaitingRoom()
}

class CustomMeetingUIViewController: UIViewController {
    
    weak var delegate: CustomMeetingUIViewControllerDelegate?
    
    var screenWidth: CGFloat {
        return view.frame.width
    }
    
    var screenHeight: CGFloat {
        return view.frame.height
    }
    
    lazy var localUserView: MobileRTCVideoView = {
        let videoView = MobileRTCVideoView(frame: CGRect(x: 15.0, y: 0.0, width: screenWidth - 30, height: (screenHeight / 4)))
        videoView.setVideoAspect(MobileRTCVideoAspect_PanAndScan)
        
        return videoView
    }()
    
    lazy var remoteUserView: MobileRTCVideoView = {
        let videoView = MobileRTCVideoView(frame: CGRect(x: 15.0, y: ((screenHeight / 4) + 15), width: screenWidth - 30, height: (screenHeight / 4)))
        videoView.setVideoAspect(MobileRTCVideoAspect_PanAndScan)
        
        return videoView
    }()
    
    lazy var activeVideoView: MobileRTCActiveVideoView = {
        let videoView = MobileRTCActiveVideoView(frame: CGRect(x: 15.0, y: (((screenHeight / 4) * 2) + 30), width: screenWidth - 30, height: (screenHeight / 4)))
        videoView.setVideoAspect(MobileRTCVideoAspect_PanAndScan)
        
        return videoView
    }()
    
    lazy var buttonContainerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceHorizontal = true
        
        return scrollView
    }()
    
    lazy var buttonStackViewView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 5
        
        return stackView
    }()
    
    lazy var leaveMeetingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Leave Meeting", for: .normal)
        button.addAction(UIAction(handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
        
        return button
    }()
    
    lazy var toggleMuteAudioButton: UIButton = {
        let button = UIButton(type: .system)
        let title = (MobileRTC.shared().getMeetingService()?.isMyAudioMuted() ?? true) ? "Unmute" : "Mute"
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(toggleMuteAudio), for: .touchUpInside)
        
        return button
    }()
    
    lazy var toggleMuteVideoButton: UIButton = {
        let button = UIButton(type: .system)
        let title = (MobileRTC.shared().getMeetingService()?.isSendingMyVideo() ?? false) ? "Stop Video" : "Start Video"
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(toggleMuteVideo), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = .black
        
        setupVideoViews()
        setupButtons()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        MobileRTC.shared().getMeetingService()?.leaveMeeting(with: .leave)
    }
    
    func setupVideoViews() {
        guard let localUserID = MobileRTC.shared().getMeetingService()?.myselfUserID() else { return }
        
        view.addSubview(localUserView)
        localUserView.showAttendeeVideo(withUserID: localUserID)
        
        if let firstRemoteUserID = MobileRTC.shared().getMeetingService()?.getInMeetingUserList()?.first(where: { UInt(truncating: $0) != localUserID }) {
            view.addSubview(remoteUserView)
            remoteUserView.showAttendeeVideo(withUserID: UInt(truncating: firstRemoteUserID))
        }
        
        view.addSubview(activeVideoView)
    }
    
    func setupButtons() {
        view.addSubview(buttonContainerScrollView)
        buttonContainerScrollView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonContainerScrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        buttonContainerScrollView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        buttonContainerScrollView.leadingAnchor.constraint(equalTo:view.leadingAnchor).isActive = true
        buttonContainerScrollView.trailingAnchor.constraint(equalTo:view.trailingAnchor).isActive = true
        
        buttonContainerScrollView.addSubview(buttonStackViewView)
        buttonStackViewView.leadingAnchor.constraint(equalTo: buttonContainerScrollView.leadingAnchor).isActive = true
        buttonStackViewView.trailingAnchor.constraint(equalTo: buttonContainerScrollView.trailingAnchor).isActive = true
        buttonStackViewView.topAnchor.constraint(equalTo: buttonContainerScrollView.topAnchor).isActive = true
        buttonStackViewView.bottomAnchor.constraint(equalTo: buttonContainerScrollView.bottomAnchor).isActive = true
        buttonStackViewView.widthAnchor.constraint(greaterThanOrEqualTo: buttonContainerScrollView.widthAnchor).isActive = true
        
        buttonStackViewView.addArrangedSubview(leaveMeetingButton)
        buttonStackViewView.addArrangedSubview(toggleMuteAudioButton)
        buttonStackViewView.addArrangedSubview(toggleMuteVideoButton)
    }
    
    func updateViews() {
        guard let meetingService = MobileRTC.shared().getMeetingService() else { return }
        let localUserID = meetingService.myselfUserID()
        localUserView.showAttendeeVideo(withUserID: localUserID)

        if let firstRemoteUserID = meetingService.getInMeetingUserList()?.first(where: { UInt(truncating: $0) != localUserID }) {
            remoteUserView.showAttendeeVideo(withUserID: UInt(truncating: firstRemoteUserID))
        }
        
        toggleMuteAudioButton.setTitle(meetingService.isMyAudioMuted() ? "Unmute" : "Mute", for: .normal)
        toggleMuteVideoButton.setTitle(meetingService.isSendingMyVideo() ? "Stop Video" : "Start Video", for: .normal)
    }
    
    @objc func toggleMuteAudio() {
        guard let meetingService = MobileRTC.shared().getMeetingService() else { return }
        
        if meetingService.isMyAudioMuted() {
            meetingService.muteMyAudio(false)
        } else {
            meetingService.muteMyAudio(true)
        }
    }
    
    @objc func toggleMuteVideo() {
        guard let meetingService = MobileRTC.shared().getMeetingService() else { return }
        
        if meetingService.isSendingMyVideo() {
            meetingService.muteMyVideo(true)
        } else {
            meetingService.muteMyVideo(false)
        }
    }
}

extension CustomMeetingUIViewController: MobileRTCMeetingServiceDelegate {
    
    func onJBHWaiting(with cmd: JBHCmd) {
        switch cmd {
        case .show:
            print("Joined before host.")
//            showAlert(with: "Joined before host.", and: "Wait for the host to start the meeting.")
        case .hide:
            print("Hide join before host message.")
        @unknown default:
            print("Unexpected error.")
        }
    }
    
    func onWaitingRoomStatusChange(_ needWaiting: Bool) {
        if needWaiting {
            print("User joined waiting room.")
//            showAlert(with: "User now in waiting room.", and: "User needs to be admitted by host or leave.", action: UIAlertAction(title: "Leave", style: .default, handler: { _ in
//                MobileRTC.shared().getMeetingService()?.leaveMeeting(with: .leave)
//            }))
        } else {
            print("User is entering meeting.")
            delegate?.userWasAdmittedFromTheWaitingRoom()
        }
    }
    
    func onMeetingError(_ error: MobileRTCMeetError, message: String?) {
        switch error {
        case .inAnotherMeeting:
            print("User is already in another meeting.")
        case .meetingNotExist:
            print("Meeting does not exist")
        case .invalidArguments:
            print("One or more of the join meeting params was invalid.")
        case .passwordError:
            print("Incorrect meeting password.")
        case .success:
            print("Meeting operation was successful.")
        default:
            print("Meeting error: \(error) \(message ?? "")")
        }
    }
    
    func onMeetingStateChange(_ state: MobileRTCMeetingState) {
        switch state {
        case .connecting:
            print("Meeting State: connecting...")
        case .ended:
            print("Meeting State: ended.")
        case .failed:
            print("Meeting State: failed.")
        case .reconnecting:
            print("Meeting State: reconnecting...")
        case .inWaitingRoom:
            print("Meeting State: in waiting room.")
        default:
            break
        }
    }
    
    func onMeetingEndedReason(_ reason: MobileRTCMeetingEndReason) {
        switch reason {
        case .connectBroken:
            print("Meeting ended due to lost connection.")
        case .endByHost:
            print("Meeting was ended by the host.")
        case .freeMeetingTimeout:
            print("Meeting ended due to free meeting limit being reached.")
        case .selfLeave:
            print("User left meeting.")
        case .removedByHost:
            print("User was removed by host.")
        default:
            print("Meeting ended with reason: \(reason)")
        }
    }
    
    func onSubscribeUserFail(_ errorCode: Int, size: Int, userId: UInt) {
        print("Failed to subscribe to user video. Error: \(errorCode)")
    }
}

extension CustomMeetingUIViewController: MobileRTCVideoServiceDelegate {
    func onSpotlightVideoUserChange(_ spotlightedUserList: [NSNumber]) {
        
    }
    
    func onHostVideoOrderUpdated(_ orderArr: [NSNumber]?) {
        
    }
    
    func onLocalVideoOrderUpdated(_ localOrderArr: [NSNumber]?) {
        
    }
    
    func onFollowHostVideoOrderChanged(_ follow: Bool) {
        
    }
    
    func onSinkMeetingVideoQualityChanged(_ qality: MobileRTCVideoQuality, userID: UInt) {
        print("onSinkMeetingVideoQualityChanged.")
    }
    
    func onSinkMeetingActiveVideo(_ userID: UInt) {
        print("Active video status changed.")
    }
    
    func onSinkMeetingVideoStatusChange(_ userID: UInt) {
        print("User video status changed: \(userID)")
    }
    
    func onMyVideoStateChange() {
        print("Local user's video status changed.")
        updateViews()
    }
    
    func onSinkMeetingVideoStatusChange(_ userID: UInt, videoStatus: MobileRTC_VideoStatus) {
        print("User video status changed: \(userID)")
        updateViews()
    }
    
    func onSpotlightVideoChange(_ on: Bool) {
        print("Spotlight status changed.")
    }
    
    func onSinkMeetingPreviewStopped() {
        print("Meeting preview ended.")
    }
    
    func onSinkMeetingActiveVideo(forDeck userID: UInt) {
        print("Active video user changed")
    }
    
    func onSinkMeetingVideoQualityChanged(_ qality: MobileRTCNetworkQuality, userID: UInt) {
        print("Video quality changed for user: \(userID)")
    }
    
    func onSinkMeetingVideoRequestUnmute(byHost completion: @escaping (Bool) -> Void) {
        print("User was asked to start video by host")
    }
    
    func onSinkMeetingShowMinimizeMeetingOrBackZoomUI(_ state: MobileRTCMinimizeMeetingState) {
        // Only for default UI.
        print("Meeting minimization was toggled. ")
    }
}
