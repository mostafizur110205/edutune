//
//  VideoTypePreviewVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 6/12/22.
//

import UIKit
import WebKit

class VideoTypePreviewVC: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var webkitView: WKWebView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var lecture: Lecture?
    var didLoadVideo = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        
        titleLabel.text = lecture?.title
        
        getLectureDetails()
    }
    
    func getLectureDetails() {
        let params = ["user_id": AppUserDefault.getUserId(), "class_id": lecture?.get_class_content_view?.class_id ?? -1, "class_content_lecture_id": lecture?.id ?? -1, "lecture_type": lecture?.type ?? -1]
        
        APIService.shared.getMyCourseWiseLessonsLecture(params: params) { lectures in
            if lectures.count>0 {
                self.lecture = lectures.first
                self.updateUI()
            }
        }
    }
    
    
    func updateUI() {
        
        webkitView.configuration.mediaTypesRequiringUserActionForPlayback = []

        let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
        webkitView.loadHTMLString(embedVideoHtml+headerString, baseURL: nil)

        let (h,m,s) = secondsToHoursMinutesSeconds(lecture?.get_video_content?.time ?? 0)
        
        var timeText = ""
        if h>0 {
            timeText += "\(h) hr "
        }
        if m>0 {
            timeText += "\(m) min "
        }
        if s>0 {
            timeText += "\(s) sec "
        }
        
        timeLabel.text = timeText
        
    }

    var embedVideoHtml:String {
            return """
                <!DOCTYPE html>
                <html>
                <body>
                <!-- 1. The <iframe> (and video player) will replace this <div> tag. -->
                <div id="player"></div>
                <script>
                var tag = document.createElement('script');
                tag.src = "https://www.youtube.com/iframe_api";
                var firstScriptTag = document.getElementsByTagName('script')[0];
                firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
                var player;
                function onYouTubeIframeAPIReady() {
                player = new YT.Player('player', {
                playerVars: { 'autoplay': 1, 'controls': 0, 'playsinline': 1 },
                height: '\(200)',
                width: '\(ScreenSize.SCREEN_WIDTH-32)',
                videoId: '\(lecture?.get_video_content?.video_id ?? "")',
                events: {
                'onReady': onPlayerReady
                }
                });
                }
                function onPlayerReady(event) {
                }
                </script>
                </body>
                </html>
                """
        }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    
}
