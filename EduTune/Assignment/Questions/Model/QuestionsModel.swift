
import Foundation

struct QuestionsModel : Codable {
    
    let error : Bool?
    let test_id : Int?
    let finish_date : String?
    let questionItems : [QuestionItemModel]?

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case test_id = "test_id"
        case finish_date = "finish_date"
        case questionItems = "questions"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(Bool.self, forKey: .error)
        test_id = try values.decodeIfPresent(Int.self, forKey: .test_id)
        finish_date = try values.decodeIfPresent(String.self, forKey: .finish_date)
        questionItems = try values.decodeIfPresent([QuestionItemModel].self, forKey: .questionItems)
    }

}
