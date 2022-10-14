//
//  MentorTVCell.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 14/10/22.
//

import UIKit

class MentorTVCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var designationNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    var teacher: Teacher? {
        didSet {
            userImageView.sd_setImage(with: URL(string: teacher?.portfolio_photo ?? "" ), placeholderImage: nil)
            usernameLabel.text = teacher?.name
            designationNameLabel.text = teacher?.designation_name
        }
    }

}
