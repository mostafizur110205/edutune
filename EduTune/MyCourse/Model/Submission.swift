//
//  Submission.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 13, 2022
//
import Foundation
import SwiftyJSON

struct Submission {

	var status: Int?
	var test_id: Int?
	var late_submission_msg: String?
	var started: String?
    var negative_marks: String?
    var view_details: String?
    var submission_date: String?
    var message: String?
    var obtain_marks: String?

    init(_ json: JSON) {
        status = json["status"].intValue
        test_id = json["test_id"].intValue
        late_submission_msg = json["late_submission_msg"].stringValue
        started = json["started"].stringValue
        negative_marks = json["negative_marks"].stringValue
        view_details = json["view_details"].stringValue
        submission_date = json["submission_date"].stringValue
        message = json["message"].stringValue
        obtain_marks = json["obtain_marks"].stringValue

	}

}
