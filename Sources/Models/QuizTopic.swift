import Foundation

enum QuizTopic: CaseIterable, Identifiable {
    case kiranameSet1, kiranameSet2, kiranameSet3

    var id: String { fileName }

    var title: String {
        switch self {
        case .kiranameSet1:   return "Kiraname問題集 セット1"
        case .kiranameSet2:   return "Kiraname問題集 セット2"
        case .kiranameSet3:   return "Kiraname問題集 セット3"
        }
    }

    var fileName: String {
        switch self {
        case .kiranameSet1:   return "quiz_kiraname_set1"
        case .kiranameSet2:   return "quiz_kiraname_set2"
        case .kiranameSet3:   return "quiz_kiraname_set3"
        }
    }
}