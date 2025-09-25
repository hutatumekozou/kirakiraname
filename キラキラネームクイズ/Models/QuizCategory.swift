import Foundation

struct QuizCategory: Identifiable, Codable {
    let id: String
    let title: String
    let questions: [Question]
}

struct QuizData: Codable {
    let categories: [QuizCategory]
}

class QuizDataLoader: ObservableObject {
    @Published var categories: [QuizCategory] = []

    init() {
        loadQuizData()
    }

    private func loadQuizData() {
        guard let path = Bundle.main.path(forResource: "questions", ofType: "json"),
              let data = NSData(contentsOfFile: path) as Data? else {
            print("Failed to load questions.json from bundle")
            loadDummyData()
            return
        }

        do {
            let quizData = try JSONDecoder().decode(QuizData.self, from: data)
            self.categories = quizData.categories
            print("Successfully loaded \(categories.count) categories")
        } catch {
            print("Failed to decode questions.json: \(error)")
            loadDummyData()
        }
    }

    private func loadDummyData() {
        let dummyQuestions = [
            Question(
                id: "dummy1",
                text: "ダミー問題です",
                choices: ["選択肢A", "選択肢B", "選択肢C", "選択肢D"],
                answerIndex: 0,
                explanation: "これはダミーの解説です"
            )
        ]

        let dummyCategory = QuizCategory(
            id: "dummy-category",
            title: "ダミーカテゴリ",
            questions: dummyQuestions
        )

        self.categories = [dummyCategory]
        print("Loaded dummy data")
    }
}