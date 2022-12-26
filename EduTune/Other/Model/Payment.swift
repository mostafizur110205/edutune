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

    var total_due_amount: String?
    var total_fine_due: String?
    var total_discount: String?

    init(_ json: JSON) {
        total_due_amount = json["total_due_amount"].stringValue
        total_fine_due = json["total_fine_due"].stringValue
        total_discount = json["total_discount"].stringValue
    }

}

//({
//  "student_data" : {
//    "total_advance" : 0,
//    "fees_heads_details" : {
//      "677" : [
//        {
//          "collection_date_name" : "Fees",
//          "start_date" : "2022-01-31",
//          "due" : 1250,
//          "fine_due" : 0,
//          "amount_paid" : 0,
//          "collection_date_id" : 2748,
//          "account_ledger_id" : 993,
//          "discount_note" : null,
//          "is_scholarship" : 0,
//          "original_fees_amount" : 1250,
//          "fees_sub_head_name" : "Fees",
//          "fine" : 0,
//          "due_amount" : 1250,
//          "note" : null,
//          "fees_head_id" : 677,
//          "fine_active_date" : "2050-01-31",
//          "fees_head_name" : "Fees",
//          "id" : 1576866,
//          "discount" : 0
//        },
//        {
//          "collection_date_name" : "Fees",
//          "start_date" : "2022-01-31",
//          "due" : 950,
//          "fine_due" : 0,
//          "amount_paid" : 0,
//          "collection_date_id" : 2748,
//          "account_ledger_id" : 993,
//          "discount_note" : null,
//          "is_scholarship" : 0,
//          "original_fees_amount" : 950,
//          "fees_sub_head_name" : "Fees",
//          "fine" : 0,
//          "due_amount" : 950,
//          "note" : null,
//          "fees_head_id" : 677,
//          "fine_active_date" : "2050-01-31",
//          "fees_head_name" : "Fees",
//          "id" : 1576867,
//          "discount" : 0
//        },
//        {
//          "fees_sub_head_name" : "Fees",
//          "discount_note" : null,
//          "note" : null,
//          "amount_paid" : 0,
//          "discount" : 0,
//          "fine_active_date" : "2050-01-31",
//          "fine_due" : 0,
//          "fees_head_name" : "Fees",
//          "collection_date_name" : "Fees",
//          "start_date" : "2022-01-31",
//          "due_amount" : 3000,
//          "fees_head_id" : 677,
//          "original_fees_amount" : 3000,
//          "account_ledger_id" : 993,
//          "is_scholarship" : 0,
//          "collection_date_id" : 2748,
//          "id" : 1576868,
//          "due" : 3000,
//          "fine" : 0
//        },
//        {
//          "collection_date_name" : "Fees",
//          "start_date" : "2022-01-31",
//          "due" : 950,
//          "fine_due" : 0,
//          "amount_paid" : 0,
//          "collection_date_id" : 2748,
//          "account_ledger_id" : 993,
//          "discount_note" : null,
//          "is_scholarship" : 0,
//          "original_fees_amount" : 950,
//          "fees_sub_head_name" : "Fees",
//          "fine" : 0,
//          "due_amount" : 950,
//          "note" : null,
//          "fees_head_id" : 677,
//          "fine_active_date" : "2050-01-31",
//          "fees_head_name" : "Fees",
//          "id" : 1576869,
//          "discount" : 0
//        },
//        {
//          "collection_date_name" : "Fees",
//          "start_date" : "2022-01-31",
//          "due" : 950,
//          "fine_due" : 0,
//          "amount_paid" : 0,
//          "collection_date_id" : 2748,
//          "account_ledger_id" : 993,
//          "discount_note" : null,
//          "is_scholarship" : 0,
//          "original_fees_amount" : 950,
//          "fees_sub_head_name" : "Fees",
//          "fine" : 0,
//          "due_amount" : 950,
//          "note" : null,
//          "fees_head_id" : 677,
//          "fine_active_date" : "2050-01-31",
//          "fees_head_name" : "Fees",
//          "id" : 1576870,
//          "discount" : 0
//        },
//        {
//          "collection_date_name" : "Fees",
//          "start_date" : "2022-01-31",
//          "due" : 1500,
//          "fine_due" : 0,
//          "amount_paid" : 0,
//          "collection_date_id" : 2748,
//          "account_ledger_id" : 993,
//          "discount_note" : null,
//          "is_scholarship" : 0,
//          "original_fees_amount" : 1500,
//          "fees_sub_head_name" : "Fees",
//          "fine" : 0,
//          "due_amount" : 1500,
//          "note" : null,
//          "fees_head_id" : 677,
//          "fine_active_date" : "2050-01-31",
//          "fees_head_name" : "Fees",
//          "id" : 1576871,
//          "discount" : 0
//        }
//      ]
//    },
//    "subtotal" : 11100,
//    "total_paid" : 2500,
//    "fine" : 0,
//    "is_advance_amount" : 0,
//    "attendance_sub_due" : 0,
//    "photo" : "https:\/\/amadereshkul.s3-ap-southeast-1.amazonaws.com\/4394ac\/ea707877-449a-47e9-a69f-ce9817097bfe\/100x120\/user\/student\/167198202144092077063a86bc53e149.jpg",
//    "discount" : 0,
//    "institution_id" : 206,
//    "future_fees_heads_details" : [
//
//    ],
//    "total_due" : 11100,
//    "is_category_amount" : 0,
//    "fees_heads_future" : [
//
//    ],
//    "attendance_sub_total" : 0,
//    "total" : 8600,
//    "attendance_sub_advance" : 0,
//    "attendance_total" : 0,
//    "date_filter" : null,
//    "attendance_total_paid" : 0,
//    "fees_head_ids" : [
//      677
//    ],
//    "student" : {
//      "present_address" : null,
//      "country_id" : 0,
//      "social_instagram_link" : null,
//      "class_id1" : null,
//      "division_id1" : null,
//      "display_name_in_device" : null,
//      "photo" : "\/user\/student\/167198202144092077063a86bc53e149.jpg",
//      "section_id1" : null,
//      "updated_at" : "2022-12-25T15:27:05.000000Z",
//      "is_alumni" : 0,
//      "student_session_id" : null,
//      "gender" : 0,
//      "mobile" : "01925727000",
//      "guardian_id" : 19523,
//      "fees_start_date" : "2022-09-19 03:10:03",
//      "email" : null,
//      "template_language" : null,
//      "social_youtube_link" : null,
//      "blood_group" : null,
//      "dob_greeting" : null,
//      "social_twitter_link" : null,
//      "student_type_id" : null,
//      "social_facebook_link" : null,
//      "merit_position" : null,
//      "name_2nd_lang" : null,
//      "hostel_room_discount_purpose" : null,
//      "institution_id" : 206,
//      "user_id" : 25806,
//      "hostel_room_discount_amount" : 0,
//      "rfid_card_id" : null,
//      "fees_category_id" : 127,
//      "status" : 2,
//      "dob" : "2022-10-20",
//      "is_tc" : 0,
//      "time_period_id" : null,
//      "roll" : 25806,
//      "admission_date" : null,
//      "class_position" : null,
//      "academic_program_id1" : null,
//      "name" : "Shipon Sarder",
//      "grading_scale_id" : null,
//      "address" : null,
//      "social_google_plus_link" : null,
//
//      "created_at" : "2022-09-19T03:10:03.000000Z",
//      "religion" : null,
//      "social_linkedin_link" : null,
//      "department_id1" : null,
//      "admission_no" : null,
//      "hostel_room_id" : null,
//      "shift_id" : null,
//      "is_dropout" : 0,
//      "id" : 69317,
//      "birth_certificate_number" : null,
//      "social_pinterest_link" : null,
//      "permanent_address" : null
//    },
//    "attendance_total_fine" : 0,
//    "fees_heads" : [
//      {
//        "name" : "Fees",
//        "total_fine_due" : 0,
//        "account_ledger_id" : 993,
//        "fees_head_id" : 677,
//        "total_discount" : 0,
//        "is_scholarship" : 0,
//        "total_fine" : 0,
//        "total_due_amount" : 8600,
//        "total_amount_paid" : 2500,
//        "type" : "2"
//      }
//    ]
//  },
//  "error" : false
//})
