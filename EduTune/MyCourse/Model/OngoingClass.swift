//
//  OngoingClass.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 13, 2022
//
import Foundation
import SwiftyJSON

struct OngoingClass {

	var id: Int?
	var mode: Int?
	var name: String?
	var photo: String?
	//var getOfferedCourses: [GetOfferedCourses]?
	var getClassContents = [ClassContent]()
	var getClassContentView = [ClassContentView]()

	init(_ json: JSON) {
		id = json["id"].intValue
		mode = json["mode"].intValue
		name = json["name"].stringValue
		//photo = json["photo"].stringValue
        if let pic = json["photo"].string {
            photo = APIEndpoints.S3_URL + (AppDelegate.shared().uuid ?? "") + pic
        }
		//getOfferedCourses = json["get_offered_courses"].arrayValue.map { GetOfferedCourses($0) }
        getClassContents = json["get_class_contents"].arrayValue.map { ClassContent(json: $0) }
        getClassContentView = json["get_class_content_view"].arrayValue.map { ClassContentView(json: $0) }
	}

}
