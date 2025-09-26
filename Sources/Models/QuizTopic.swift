import Foundation

enum QuizTopic: CaseIterable, Identifiable {
    case kiranameSet1, kiranameSet2, kiranameSet3, kiranameSet4, kiranameSet5, kiranameSet6

    var id: String { fileName }

    var title: String {
        switch self {
        case .kiranameSet1:   return "DQNネーム 30-21位"
        case .kiranameSet2:   return "DQNネーム 20-11位"
        case .kiranameSet3:   return "DQNネーム 10-1位"
        case .kiranameSet4:   return "Kiraname問題集 セット4"
        case .kiranameSet5:   return "Kiraname問題集 セット5"
        case .kiranameSet6:   return "Kiraname問題集 セット6"
        }
    }

    var fileName: String {
        switch self {
        case .kiranameSet1:   return "quiz_kiraname_set1"
        case .kiranameSet2:   return "quiz_kiraname_set2"
        case .kiranameSet3:   return "quiz_kiraname_set3"
        case .kiranameSet4:   return "quiz_kiraname_set4"
        case .kiranameSet5:   return "quiz_kiraname_set5"
        case .kiranameSet6:   return "quiz_kiraname_set6"
        }
    }
}