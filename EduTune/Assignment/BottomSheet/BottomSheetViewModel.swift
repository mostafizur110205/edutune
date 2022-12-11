//
//  BottomSheetViewModel.swift
//  EduTune
//
//  Created by DH on 11/12/22.
//

import Foundation
import UIKit

public protocol BRQBottomSheetPresentable {
    var cornerRadius: CGFloat { get set }
    var animationTransitionDuration: TimeInterval { get set }
    var backgroundColor: UIColor { get set }
}

public struct BottomSheetViewModel: BRQBottomSheetPresentable {
   
    public var cornerRadius: CGFloat
    public var animationTransitionDuration: TimeInterval
    public var backgroundColor: UIColor
    
    public init() {
        cornerRadius = 20
        animationTransitionDuration = 0.3
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    public init(cornerRadius: CGFloat,
                animationTransitionDuration: TimeInterval,
                backgroundColor: UIColor ) {
        
        self.cornerRadius = cornerRadius
        self.animationTransitionDuration = animationTransitionDuration
        self.backgroundColor = backgroundColor
    }
}
