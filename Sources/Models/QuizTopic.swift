import Foundation

enum QuizTopic: CaseIterable, Identifiable {
    case kiranameSet6, kiranameSet7, kiranameSet6_2, kiranameSet1, kiranameSet2, kiranameSet3

    var id: String { fileName }

    var title: String {
        switch self {
        case .kiranameSet6:   return "Kiraname 問題集セット1"
        case .kiranameSet7:   return "Kiraname 問題集セット2"
        case .kiranameSet6_2: return "Kiraname 問題集セット3"
        case .kiranameSet1:   return "DQNネーム1-10"
        case .kiranameSet2:   return "DQNネーム11-20"
        case .kiranameSet3:   return "DQNネーム21-30"
        }
    }

    var fileName: String {
        switch self {
        case .kiranameSet6:   return "quiz_kiraname_set1"
        case .kiranameSet7:   return "quiz_kiraname_set2"
        case .kiranameSet6_2: return "quiz_kiraname_set3"
        case .kiranameSet1:   return "quiz_kiraname_set4"
        case .kiranameSet2:   return "quiz_kiraname_set5"
        case .kiranameSet3:   return "quiz_kiraname_set6"
        }
    }
}