import Foundation

enum QuizTopic: CaseIterable, Identifiable {
    case kiranameSet6, kiranameSet7, kiranameSet6_2, kiranameSet1, kiranameSet2, kiranameSet3, boyKiraname1, boyKiraname2, boyKiraname3

    var id: String { fileName }

    var title: String {
        switch self {
        case .kiranameSet6:   return "人気キラキラネーム-1"
        case .kiranameSet7:   return "人気キラキラネーム-2"
        case .kiranameSet6_2: return "人気キラキラネーム-3"
        case .kiranameSet1:   return "女の子キラキラネーム 1-10"
        case .kiranameSet2:   return "女の子キラキラネーム 11-20"
        case .kiranameSet3:   return "女の子キラキラネーム 21-30"
        case .boyKiraname1:   return "男の子キラキラネーム1-10"
        case .boyKiraname2:   return "男の子キラキラネーム11-20"
        case .boyKiraname3:   return "男の子キラキラネーム21-30"
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
        case .boyKiraname1:   return "quiz_kiraname_set7"
        case .boyKiraname2:   return "quiz_kiraname_set8"
        case .boyKiraname3:   return "quiz_kiraname_set9"
        }
    }
}