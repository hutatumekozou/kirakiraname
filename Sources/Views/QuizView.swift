import SwiftUI

struct QuizStarPatternView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<15, id: \.self) { index in
                    Image(systemName: "star.fill")
                        .foregroundColor(.white)
                        .font(.system(size: CGFloat.random(in: 12...20)))
                        .position(
                            x: CGFloat.random(in: 20...(geometry.size.width - 20)),
                            y: CGFloat.random(in: 50...(geometry.size.height - 50))
                        )
                        .opacity(0.6)
                }
            }
        }
    }
}

struct QuizView: View {
    let topic: QuizTopic
    @State private var questions: [Question] = []
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: Int? = nil
    @State private var showExplanation = false
    @State private var correctAnswers = 0
    @State private var navigateToResult = false
    
    var body: some View {
        ZStack {
            // 桃色背景
            Color(red: 1.0, green: 0.75, blue: 0.8)
                .ignoresSafeArea()

            // 星の装飾
            QuizStarPatternView()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                if !questions.isEmpty {
                    // 問題番号表示
                    HStack {
                        Text("第\(currentQuestionIndex + 1)問")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("\(currentQuestionIndex + 1) / \(questions.count)")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text("items:\(questions.count)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)
                    
                    // 問題文
                    Text(questions[currentQuestionIndex].text)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    
                    // 選択肢
                    VStack(spacing: 12) {
                        ForEach(0..<questions[currentQuestionIndex].choices.count, id: \.self) { index in
                            let choiceLabels = ["A.", "B.", "C.", "D."]
                            Button(action: {
                                if selectedAnswer == nil {
                                    selectedAnswer = index
                                    showExplanation = true
                                }
                            }) {
                                HStack(alignment: .top, spacing: 12) {
                                    Text(choiceLabels[index])
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
                                    Text(questions[currentQuestionIndex].choices[index])
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                .padding()
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(
                                    Group {
                                        if showExplanation {
                                            if index == questions[currentQuestionIndex].correct {
                                                Color.green.opacity(0.3)
                                            } else if index == selectedAnswer {
                                                Color.red.opacity(0.3)
                                            } else {
                                                Color.white
                                            }
                                        } else {
                                            Color.white
                                        }
                                    }
                                )
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                            }
                            .disabled(selectedAnswer != nil)
                        }
                    }
                    .padding(.horizontal)
                    
                    // 正解・不正解表示と解説
                    if showExplanation {
                        VStack(spacing: 12) {
                            // 正解・不正解表示
                            Text(selectedAnswer == questions[currentQuestionIndex].correct ? "正解！" : "不正解")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(selectedAnswer == questions[currentQuestionIndex].correct ? .black : .red)
                                .padding(.horizontal)
                            
                            // 解説
                            Text(questions[currentQuestionIndex].explanation)
                                .font(.body)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .padding()
                                .background(Color.white.opacity(0.9))
                                .cornerRadius(12)
                                .padding(.horizontal)
                        }
                        
                        Button(action: nextQuestion) {
                            Text(currentQuestionIndex == questions.count - 1 ? "結果を見る" : "次の問題")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(Color(red: 0.2, green: 0.4, blue: 0.8))
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(topic.title)
        .navigationBarBackButtonHidden(false)
        .onAppear {
            loadQuestions()
        }
        .background(
            NavigationLink(
                destination: ResultView(topic: topic, correctAnswers: correctAnswers, totalQuestions: questions.count),
                isActive: $navigateToResult,
                label: { EmptyView() }
            )
        )
    }
    
    private func loadQuestions() {
        questions = QuizRepository.shared.loadQuestions(for: topic)
        let usedFallback = questions.count >= 10 ? false : true
        print("[UI] start items=\(questions.count) fallback=\(usedFallback)")
    }
    
    private func nextQuestion() {
        if let selected = selectedAnswer, selected == questions[currentQuestionIndex].correct {
            correctAnswers += 1
        }
        
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            selectedAnswer = nil
            showExplanation = false
        } else {
            navigateToResult = true
        }
    }
}