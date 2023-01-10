//
//  OptionsTableViewCell.swift
//  EduTune
//
//  Created by DH on 10/1/23.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {
    static let reuseIdentifier = "OptionCell"
    
    var deselectedTintColor: UIColor?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Our Gridicons look slightly better if shifted down one px
        imageView?.frame.origin.y += 1
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Icons should always appear deselected
        imageView?.tintColor = deselectedTintColor
        accessoryType = selected ? .checkmark : .none
    }
}
