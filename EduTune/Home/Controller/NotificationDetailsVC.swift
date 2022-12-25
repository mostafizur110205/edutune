//
//  NotificationDetailsVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 25/12/22.
//

import UIKit

class NotificationDetailsVC: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    var notification: Notification?
    var icon: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        update()
    }
    
    func update() {
        titleLabel.text = notification?.subject
        subtitleLabel.text = notification?.message
        dateLabel.text = notification?.created_at

        mainImageView.sd_setImage(with: URL(string: notification?.image ?? ""), placeholderImage: icon)

    }
    
    @IBAction func onCrossButtonTap(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
