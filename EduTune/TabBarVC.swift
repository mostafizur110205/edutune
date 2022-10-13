//
//  TabBarVC.swift
//  Trendit
//
//  Created by Mostafizur Rahman on 28/6/22.
//

import UIKit
import SDWebImage

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppUserDefault.setIsAppOpened(true)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(self.profileInfoFetched), name: Notification.Name("ProfileInfoFetched"), object: nil)
//
//        profileInfoFetched()
        
    }
    
//    @objc func profileInfoFetched() {
//        SDWebImageManager.shared.loadImage (
//            with: URL(string: AppUserDefault.getPicture() ?? ""),
//            options: .continueInBackground,
//            progress: nil,
//            completed: { [weak self] (image, data, error, cacheType, finished, url) in
//                guard let sself = self else { return }
//
//                var tabbarImage = SocketClient.shared.getLetterAvater(SocketClient.shared.user?.fullname ?? "")
//
//                if let img = image {
//                    tabbarImage = img
//                }
//
//                let iconImage = tabbarImage?.scalePreservingAspectRatio(targetSize: CGSize(width: 30, height: 30)).withRenderingMode(.alwaysOriginal)
//                sself.tabBar.items?[4].image = iconImage
//                sself.tabBar.items?[4].selectedImage = iconImage
//
//            }
//        )
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
