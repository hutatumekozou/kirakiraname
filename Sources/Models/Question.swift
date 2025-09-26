import Foundation

struct Question: Codable, Identifiable {
    let id = UUID()
    let title: String
    let question: String
    let choices: [String]
    let answerIndex: Int
    let explanation: String

    enum CodingKeys: String, CodingKey {
        case title, question, choices, answerIndex, explanation
    }

    var text: String {
        return question
    }

    var correct: Int {
        return answerIndex
    }
}