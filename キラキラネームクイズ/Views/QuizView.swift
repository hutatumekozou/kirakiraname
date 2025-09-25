import SwiftUI

struct QuizView: View {
    let category: QuizCategory

    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: Int? = nil
    @State private var showExplanation = false
    @State private var correctAnswers = 0
    @State private var isQuizComplete = false

    var currentQuestion: Question {
        category.questions[currentQuestionIndex]
    }

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.cyan.opacity(0.6)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
                VStack(spacing: 10) {
                    Text("第\(currentQuestionIndex + 1)問")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text("\(currentQuestionIndex + 1) / \(category.questions.count)")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text(currentQuestion.text)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)

                    VStack(spacing: 12) {
                        ForEach(0..<currentQuestion.choices.count, id: \.self) { index in
                            ChoiceButton(
                                choice: currentQuestion.choices[index],
                                label: ["A", "B", "C", "D"][index],
                                isSelected: selectedAnswer == index,
                                isCorrect: index == currentQuestion.answerIndex,
                                showResult: showExplanation
                            ) {
                                if !showExplanation {
                                    selectedAnswer = index
                                    showExplanation = true
                                    if index == currentQuestion.answerIndex {
                                        correctAnswers += 1
                                    }
                                }
                            }
                        }
                    }

                    if showExplanation {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("解説")
                                .font(.headline)
                                .foregroundColor(.primary)

                            Text(currentQuestion.explanation)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color.yellow.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                .padding(.horizontal, 20)

                if showExplanation {
                    Button(action: nextQuestion) {
                        Text(currentQuestionIndex == category.questions.count - 1 ? "結果を見る" : "次の問題")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                }

                Spacer()
            }
            .padding(.top, 20)
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(
            NavigationLink(
                destination: ResultView(
                    totalQuestions: category.questions.count,
                    correctAnswers: correctAnswers,
                    categoryTitle: category.title
                ),
                isActive: $isQuizComplete
            ) {
                EmptyView()
            }
        )
    }

    private func nextQuestion() {
        if currentQuestionIndex == category.questions.count - 1 {
            isQuizComplete = true
        } else {
            currentQuestionIndex += 1
            selectedAnswer = nil
            showExplanation = false
        }
    }
}

struct ChoiceButton: View {
    let choice: String
    let label: String
    let isSelected: Bool
    let isCorrect: Bool
    let showResult: Bool
    let action: () -> Void

    var backgroundColor: Color {
        if !showResult {
            return isSelected ? Color.blue.opacity(0.2) : Color.white
        } else {
            if isCorrect {
                return Color.green.opacity(0.2)
            } else if isSelected && !isCorrect {
                return Color.red.opacity(0.2)
            } else {
                return Color.white
            }
        }
    }

    var borderColor: Color {
        if !showResult {
            return isSelected ? Color.blue : Color.gray.opacity(0.3)
        } else {
            if isCorrect {
                return Color.green
            } else if isSelected && !isCorrect {
                return Color.red
            } else {
                return Color.gray.opacity(0.3)
            }
        }
    }

    var body: some View {
        Button(action: action) {
            HStack {
                Text("\(label).")
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(choice)
                    .font(.body)
                    .foregroundColor(.primary)

                Spacer()

                if showResult && isCorrect {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                } else if showResult && isSelected && !isCorrect {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                }
            }
            .padding()
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor, lineWidth: 2)
            )
        }
        .disabled(showResult)
    }
}

#Preview {
    let sampleQuestion = Question(
        id: "sample",
        text: "「昊空」の\"キラキラ読み\"として紹介されるのはどれ？",
        choices: ["そら", "あくあ", "こうくう", "たかそら"],
        answerIndex: 0,
        explanation: "1位「昊空＝そら」。"
    )

    let sampleCategory = QuizCategory(
        id: "sample",
        title: "サンプル",
        questions: [sampleQuestion]
    )

    QuizView(category: sampleCategory)
}