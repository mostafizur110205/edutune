//
//  OptionsTableViewOption.swift
//  EduTune
//
//  Created by DH on 10/1/23.
//


import UIKit

/// Encapsulates data for a row in an `OptionsTableView`.
///
public struct OptionsTableViewOption: Equatable {
    let image: UIImage?
    let title: NSAttributedString
    let accessibilityLabel: String?
    
    // MARK: - Initializer
    
    public init(image: UIImage?, title: NSAttributedString, accessibilityLabel: String? = nil) {
        self.image = image
        self.title = title
        self.accessibilityLabel = accessibilityLabel
    }
    
    // MARK: - Equatable
    
    public static func ==(lhs: OptionsTableViewOption, rhs: OptionsTableViewOption) -> Bool {
        return lhs.title == rhs.title
    }
}
