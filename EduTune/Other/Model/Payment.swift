//
//  Invoice.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 18, 2022
//
import Foundation
import SwiftyJSON

struct Invoice {

    var id: Int?
	var payment_ref: String?
	var payment_mode: String?
    var created_at: String?
    var amount: String?

	init(_ json: JSON) {
        id = json["id"].int
        payment_ref = json["payment_ref"].string
        payment_mode = json["payment_mode"].string
        created_at = json["created_at"].string
        amount = json["amount"].stringValue
	}

}

struct DueFees {

    var total_due: Float?
    var total_paid: Float?
    var discount: Float?
    var fine: Float?

    var fees_heads = [FeesHeads]()

    init(_ json: JSON) {
        total_due = json["total_due"].floatValue
        total_paid = json["total_paid"].floatValue
        discount = json["discount"].floatValue
        fine = json["fine"].floatValue

        fees_heads = json["fees_heads"].arrayValue.map({ FeesHeads($0) })

    }

}

struct FeesHeads {

    var name: String?
    var total_due_amount: String?

    init(_ json: JSON) {
        name = json["name"].stringValue
        total_due_amount = json["total_due_amount"].stringValue

    }

}
