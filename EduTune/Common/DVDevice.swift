//
//  DVDevice.swift
//  BOOM SOCCER
//
//  Created by Mostafizur Rahman on 26/5/20.
//  Copyright © 2020 PEEMZ. All rights reserved.


import UIKit

struct ScreenSize{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}
