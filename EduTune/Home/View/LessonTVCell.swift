//
//  LessonTVCell.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 22/10/22.
//

import UIKit

class LessonTVCell: UITableViewCell {
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
