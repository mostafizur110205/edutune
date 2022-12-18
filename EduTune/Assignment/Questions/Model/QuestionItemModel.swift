
import Foundation

enum QuestionType: Int, Codable {
    case multipleChoice = 1
    case multipleAnswer = 2
    case trueFalse = 3
    case essay = 4
    case filInTheBlanks = 7
    case fileResponse = 9
    case shortAnswer = 11
}

struct QuestionItemModel : Codable {
    
	let id : Int?
	let institutionId : Int?
	let assignmentId : Int?
	let classId : Int?
	let sectionId : Int?
	let offeredCourseId : Int?
	let questionType : QuestionType?
	let title : String?
	let htmlTitle : String?
	let answerExplanation : String?
	let point : Int?
	let time : String?
	let questionId : String?
	let createdAt : String?
	let updatedAt : String?
    var questionOptions : [QuestionOptionsModel]?

	enum CodingKeys: String, CodingKey {
		case id = "id"
		case institutionId = "institution_id"
		case assignmentId = "assignment_id"
		case classId = "class_id"
		case sectionId = "section_id"
		case offeredCourseId = "offered_course_id"
		case questionType = "question_type"
		case title = "title"
		case htmlTitle = "html_title"
		case answerExplanation = "answer_explanation"
		case point = "point"
		case time = "time"
		case questionId = "question_id"
		case createdAt = "created_at"
		case updatedAt = "updated_at"
		case questionOptions = "get_question_options"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
        institutionId = try values.decodeIfPresent(Int.self, forKey: .institutionId)
        assignmentId = try values.decodeIfPresent(Int.self, forKey: .assignmentId)
        classId = try values.decodeIfPresent(Int.self, forKey: .classId)
        sectionId = try values.decodeIfPresent(Int.self, forKey: .sectionId)
        offeredCourseId = try values.decodeIfPresent(Int.self, forKey: .offeredCourseId)
        questionType = try values.decodeIfPresent(QuestionType.self, forKey: .questionType)
		title = try values.decodeIfPresent(String.self, forKey: .title)
        htmlTitle = try values.decodeIfPresent(String.self, forKey: .htmlTitle)
        answerExplanation = try values.decodeIfPresent(String.self, forKey: .answerExplanation)
		point = try values.decodeIfPresent(Int.self, forKey: .point)
		time = try values.decodeIfPresent(String.self, forKey: .time)
        questionId = try values.decodeIfPresent(String.self, forKey: .questionId)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        questionOptions = try values.decodeIfPresent([QuestionOptionsModel].self, forKey: .questionOptions)
        
        guard questionOptions?.count == 0 else {return}
        questionOptions = [QuestionOptionsModel(id: id, institutionId: institutionId, questionId: 0, optionOrder: 0, optionTitle: "", isCorrect: 0, explanation: "", createdAt: createdAt, updatedAt: updatedAt)]
	}

}
