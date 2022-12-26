//
//  Syllabus.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 18, 2022
//
import Foundation
import SwiftyJSON

struct Syllabus {

    var goal_class_id: Int?
	var goal_group_id: Int?
    var default_goals = [UserGoal]()

	init(_ json: JSON) {
        goal_class_id = json["goal_class_id"].int
        goal_group_id = json["goal_group_id"].int
        default_goals = json["default_goals"].arrayValue.map { UserGoal($0) }
	}
}

struct UserGoal {
    var id: Int?
    var name: String?
    var icon: String?
    var group = [UserGoal]()

    init(_ json: JSON) {
        id = json["id"].int
        name = json["name"].string
        icon = json["icon"].string
        group = json["group"].arrayValue.map { UserGoal($0) }

    }
}
