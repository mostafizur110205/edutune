//
//  HomeHeaderTVCell.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 25/12/22.
//

import UIKit

protocol HomeHeaderTVCellDelegate {
    func didSeeAllButtonTap()
}

class HomeHeaderTVCell: UITableViewCell {
 
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sellAllButton: UIButton!
    
    var delegate: HomeHeaderTVCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func onSeeAllButtonTap(_ sender: UIButton) {
        delegate?.didSeeAllButtonTap()
    }
    
}
