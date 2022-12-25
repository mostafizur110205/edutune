//
//  Help.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 18, 2022
//
import Foundation
import SwiftyJSON

struct Help {

	var terms_and_conditions: String?
	var refund_policy: String?
    var privacy_policy: String?
    var faqs = [FAQ]()
    var customer_service: String?
    var whatsapp: String?
    var website: String?
    var linkedin_page: String?
    var facebook_page: String?
    var youtube_channel: String?


	init(_ json: JSON) {
        terms_and_conditions = json["terms_and_conditions"].string
        refund_policy = json["refund_policy"].string
        privacy_policy = json["privacy_policy"].string
        faqs = json["faqs"].arrayValue.map { FAQ($0) }
        customer_service = json["customer_service"].string
        whatsapp = json["whatsapp"].string
        website = json["website"].string
        linkedin_page = json["linkedin_page"].string
        facebook_page = json["facebook_page"].string
        youtube_channel = json["youtube_channel"].string

	}

}

struct FAQ {

    var title: String?
    var description: String?

    init(_ json: JSON) {
        title = json["title"].string
        description = json["description"].string
    }

}
