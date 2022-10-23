//
//  LoginTVCell.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 13/10/22.
//

import UIKit

class LoginTVCell: UITableViewCell {

    @IBOutlet weak var mainContentView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        mainContentView.layer.masksToBounds = false
        mainContentView.layer.shadowColor = UIColor.init(hex: "535990", alpha: 0.2).cgColor
        mainContentView.layer.cornerRadius = 10.0
        mainContentView.layer.shadowOffset = CGSize(width: 0, height: 3)
        mainContentView.layer.shadowRadius = 5
        mainContentView.layer.shadowOpacity = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
