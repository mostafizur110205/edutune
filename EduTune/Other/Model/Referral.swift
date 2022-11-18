//
//  Referral.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 18, 2022
//
import Foundation
import SwiftyJSON

struct Referral {

	var error: Bool?
	var userPoints: [Any]?
	var pointBalance: Int?
	var pointRequested: Int?
	var pointCancelled: Int?
	var totalRedeem: Int?
	var services: [String: Any]?
	var minRedeemLimit: Int?
	var perSignupPoint: Int?
	var myPointRedeemRequest: [Any]?
	var status: [String: Any]?
	var statusColor: [String: Any]?
	var faqQuestion: [String]?
	var faqAnswer: [String]?

	init(_ json: JSON) {
		error = json["error"].boolValue
		userPoints = json["userPoints"].arrayValue.map { $0 }
		pointBalance = json["point_balance"].intValue
		pointRequested = json["point_requested"].intValue
		pointCancelled = json["point_cancelled"].intValue
		totalRedeem = json["total_redeem"].intValue
        services = json["services"].rawValue as? [String : Any]
		minRedeemLimit = json["min_redeem_limit"].intValue
		perSignupPoint = json["perSignupPoint"].intValue
		myPointRedeemRequest = json["myPointRedeemRequest"].arrayValue.map { $0 }
		status = json["status"].rawValue as? [String : Any]
		statusColor = json["statusColor"].rawValue as? [String : Any]
		faqQuestion = json["faqQuestion"].arrayValue.map { $0.stringValue }
		faqAnswer = json["faqAnswer"].arrayValue.map { $0.stringValue }
	}

}
