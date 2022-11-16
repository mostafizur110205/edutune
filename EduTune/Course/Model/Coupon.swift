//
//  Coupon.swift
//  Trendit
//
//  Created by Mostafizur Rahman on 2/7/22.
//

import SwiftyJSON

class Coupon: NSObject {
    
    var set_cart_amount: Int?
    var discount: Int?
    var discount_message: String?
   
    required init(json: JSON) {
        set_cart_amount = json["set_cart_amount"].int
        discount = json["discount"].int
        discount_message = json["discount_message"].string
    }
}
