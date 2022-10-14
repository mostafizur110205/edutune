//
//  HomeHelpCell.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 13/10/22.
//

import UIKit
import SDWebImage

class HomeHelpCell: UITableViewCell {
    
    @IBOutlet weak var text1Label: UILabel!
    @IBOutlet weak var text2Label: UILabel!
    @IBOutlet weak var text3Label: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var helpImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
        
    @IBAction func onPhoneButtomTap(_ sender: Any) {
        if let url = URL(string: "tel://\(institution?.support_text3 ?? "")"),
           UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // add error message here
        }
    }
    
    var institution: Institution? {
        didSet {
            text1Label.text = institution?.support_title
            text2Label.text = institution?.support_text1
            text3Label.text = institution?.support_text2
            helpImageView.sd_setImage(with: URL(string: institution?.support_image ?? "" ), placeholderImage: nil)
            phoneButton.setTitle(institution?.support_text3, for: .normal)
        }
    }
    
}
