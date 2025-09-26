import SwiftUI

struct ResultView: View {
    let totalQuestions: Int
    let correctAnswers: Int
    let categoryTitle: String

    @Environment(\.dismiss) private var dismiss

    private var correctPercentage: Double {
        return totalQuestions > 0 ? Double(correctAnswers) / Double(totalQuestions) * 100 : 0
    }

    private var motivationMessage: String {
        switch correctPercentage {
        case 90...100:
            return "素晴らしい！キラキラネームマスターです！"
        case 70..<90:
            return "とても良くできました！"
        case 50..<70:
            return "まずまずですね。もう少し頑張りましょう！"
        default:
            return "もう一度チャレンジしてみましょう！"
        }
    }

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.cyan.opacity(0.6)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(spacing: 20) {
                    Text("結果発表")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .scaleEffect(1.5)
                }
                .padding(.top, 60)
                .padding(.bottom, 40)

                VStack(spacing: 30) {
                    VStack(spacing: 20) {
                        ZStack {
                            Circle()
                                .stroke(Color.gray.opacity(0.3), lineWidth: 12)
                                .frame(width: 120, height: 120)

                            Circle()
                                .trim(from: 0, to: correctPercentage / 100)
                                .stroke(Color.green, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                                .frame(width: 120, height: 120)
                                .rotationEffect(.degrees(-90))

                            Text("\(Int(correctPercentage))%")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                        }

                        VStack(spacing: 8) {
                            Text("\(correctAnswers) / \(totalQuestions) 問正解")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)

                            Text(motivationMessage)
                                .font(.body)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.8)
                        }
                    }
                    .padding(30)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)

                    Button(action: {
                        dismiss()
                    }) {
                        Text("最初に戻る")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 40)

                    Spacer()
                }
                .padding(.horizontal, 30)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ResultView(totalQuestions: 10, correctAnswers: 8, categoryTitle: "キラキラネーム人気ランキング1-10位")
}