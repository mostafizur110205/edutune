
import Foundation

struct QuestionOptionsModel : Codable {
    
	let id : Int?
	let institutionId : Int?
	let questionId : Int?
	let optionOrder : Int?
	let optionTitle : String?
	let isCorrect : Int?
	let explanation : String?
	let createdAt : String?
	let updatedAt : String?

	enum CodingKeys: String, CodingKey {
		case id = "id"
		case institutionId = "institution_id"
		case questionId = "question_id"
		case optionOrder = "option_order"
		case optionTitle = "option_title"
		case isCorrect = "isCorrect"
		case explanation = "explanation"
		case createdAt = "created_at"
		case updatedAt = "updated_at"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		institutionId = try values.decodeIfPresent(Int.self, forKey: .institutionId)
		questionId = try values.decodeIfPresent(Int.self, forKey: .questionId)
		optionOrder = try values.decodeIfPresent(Int.self, forKey: .optionOrder)
		optionTitle = try values.decodeIfPresent(String.self, forKey: .optionTitle)
		isCorrect = try values.decodeIfPresent(Int.self, forKey: .isCorrect)
		explanation = try values.decodeIfPresent(String.self, forKey: .explanation)
		createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
		updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
	}

}
