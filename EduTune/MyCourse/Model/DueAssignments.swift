//
//  DueAssignments.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 13, 2022
//
import Foundation
import SwiftyJSON

struct DueAssignments {

	var id: Int?
	var type: Int?
	var institutionId: Int?
	var assignmentTypeId: Any?
	var examId: Any?
	var teacherId: Int?
	var classId: Int?
	var sectionId: Any?
	var offeredCourseId: Int?
	var assignmentMarksDisplay: Int?
	var submissionSelectionType: Any?
	var name: String?
	var assignmentType: Int?
	var description: Any?
	var file: Any?
	var fileName: Any?
	var dueDate: String?
	var availableAfter: Any?
	var availableUntil: Any?
	var examTime: Int?
	var status: Int?
	var assignmentShowMode: Int?
	var numOfAttempts: Int?
	var checkPlagiarism: Any?
	var allowStudentOriginalityReport: Any?
	var negativeMarkingPercentage: Any?
	var classContentLectureId: Int?
	var createdAt: String?
	var updatedAt: String?
	var className: String?
	var subjectName: String?
	var subjectImage: String?
	var getQuestionsCount: Int?
	var getSubmissionsCount: Int?
	var instruction: String?
	var isLive: Int?
	var isTestEnable: Int?

	init(_ json: JSON) {
		id = json["id"].intValue
		type = json["type"].intValue
		institutionId = json["institution_id"].intValue
		assignmentTypeId = json["assignment_type_id"]
		examId = json["exam_id"]
		teacherId = json["teacher_id"].intValue
		classId = json["class_id"].intValue
		sectionId = json["section_id"]
		offeredCourseId = json["offered_course_id"].intValue
		assignmentMarksDisplay = json["assignment_marks_display"].intValue
		submissionSelectionType = json["submission_selection_type"]
		name = json["name"].stringValue
		assignmentType = json["assignment_type"].intValue
		description = json["description"]
		file = json["file"]
		fileName = json["file_name"]
		dueDate = json["due_date"].stringValue
		availableAfter = json["available_after"]
		availableUntil = json["available_until"]
		examTime = json["exam_time"].intValue
		status = json["status"].intValue
		assignmentShowMode = json["assignment_show_mode"].intValue
		numOfAttempts = json["num_of_attempts"].intValue
		checkPlagiarism = json["check_plagiarism"]
		allowStudentOriginalityReport = json["allow_student_originality_report"]
		negativeMarkingPercentage = json["negative_marking_percentage"]
		classContentLectureId = json["class_content_lecture_id"].intValue
		createdAt = json["created_at"].stringValue
		updatedAt = json["updated_at"].stringValue
		className = json["class_name"].stringValue
		subjectName = json["subject_name"].stringValue
		//subjectImage = json["subject_image"].stringValue
        if let pic = json["subject_image"].string {
            subjectImage = APIEndpoints.S3_URL + (AppDelegate.shared().uuid ?? "") + pic
        }
		getQuestionsCount = json["get_questions_count"].intValue
		getSubmissionsCount = json["get_submissions_count"].intValue
		instruction = json["instruction"].stringValue
		isLive = json["is_live"].intValue
		isTestEnable = json["is_test_enable"].intValue
	}

}
