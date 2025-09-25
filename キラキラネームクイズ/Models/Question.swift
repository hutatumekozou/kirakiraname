import Foundation

struct Question: Identifiable, Codable {
    let id: String
    let text: String
    let choices: [String]
    let answerIndex: Int
    let explanation: String

    var correctAnswer: String {
        return choices[answerIndex]
    }
}