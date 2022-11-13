//
//  LiveClass.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 13, 2022
//
import Foundation
import SwiftyJSON

struct LiveClass {

	var id: Int?
	var institutionId: Int?
	var classId: Int?
	var sectionId: Any?
	var shiftId: Any?
	var offeredCourseId: String?
	var academicYearId: Int?
	var seasonalRoutineId: Any?
	var roomId: Any?
	var day: String?
	var startTime: String?
	var endTime: String?
	var isBreak: String?
	var link: Any?
	var liveClassHost: Int?
	var isAssemblyTime: Int?
	var createdAt: Any?
	var updatedAt: String?
	var className: String?
	var hostLink: String?
	var hostName: String?
	var zoomJwtApiKey: String?
	var zoomJwtSecretKey: String?
	var zoomHostMode: Int?
	var liveClassPlatform: Int?
	var facebookMessengerLink: String?
	var image: String?
	var divisionId: Any?
	var startDateTime: Int?
	var endDateTime: Int?
	//var courses: [Courses]?
	//var teachers: [Teachers]?
	var teacherStr: String?
	var teacherFullStr: String?
	//var getOfferedCourse: GetOfferedCourse?

	init(_ json: JSON) {
		id = json["id"].intValue
		institutionId = json["institution_id"].intValue
		classId = json["class_id"].intValue
		sectionId = json["section_id"]
		shiftId = json["shift_id"]
		offeredCourseId = json["offered_course_id"].stringValue
		academicYearId = json["academic_year_id"].intValue
		seasonalRoutineId = json["seasonal_routine_id"]
		roomId = json["room_id"]
		day = json["day"].stringValue
		startTime = json["start_time"].stringValue
		endTime = json["end_time"].stringValue
		isBreak = json["is_break"].stringValue
		link = json["link"]
		liveClassHost = json["live_class_host"].intValue
		isAssemblyTime = json["is_assembly_time"].intValue
		createdAt = json["created_at"]
		updatedAt = json["updated_at"].stringValue
		className = json["class_name"].stringValue
		hostLink = json["host_link"].stringValue
		hostName = json["host_name"].stringValue
		zoomJwtApiKey = json["zoom_jwt_api_key"].stringValue
		zoomJwtSecretKey = json["zoom_jwt_secret_key"].stringValue
		zoomHostMode = json["zoom_host_mode"].intValue
		liveClassPlatform = json["live_class_platform"].intValue
		facebookMessengerLink = json["facebook_messenger_link"].stringValue
		//image = json["image"].stringValue
        if let pic = json["image"].string {
            image = APIEndpoints.S3_URL + (AppDelegate.shared().uuid ?? "") + pic
        }
		divisionId = json["division_id"]
		startDateTime = json["start_date_time"].intValue
		endDateTime = json["end_date_time"].intValue
		//courses = json["courses"].arrayValue.map { Courses($0) }
		//teachers = json["teachers"].arrayValue.map { Teachers($0) }
		teacherStr = json["teacher_str"].stringValue
		teacherFullStr = json["teacher_full_str"].stringValue
		//getOfferedCourse = GetOfferedCourse(json["get_offered_course"])
	}

}
