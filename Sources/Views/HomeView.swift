import SwiftUI

struct PrimaryQuizLink: View {
    let title: String
    let topic: QuizTopic

    var body: some View {
        NavigationLink(destination: QuizView(topic: topic)) {
            Text(title)
                .font(.title3.weight(.bold))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .foregroundColor(Color.blue)
                .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 64)
                .padding(.horizontal, 4)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.08), radius: 8, y: 2)
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Text(title))
    }
}

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // 桃色背景
                Color(red: 1.0, green: 0.75, blue: 0.8)
                    .ignoresSafeArea()

                // コンテンツ本体（必要時のみスクロール）
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 12) {
                        // 6つのクイズボタン
                        PrimaryQuizLink(title: "Kiraname 問題集セット1", topic: .kiranameSet6)

                        PrimaryQuizLink(title: "Kiraname 問題集セット2", topic: .kiranameSet7)

                        PrimaryQuizLink(title: "Kiraname 問題集セット3", topic: .kiranameSet6_2)

                        PrimaryQuizLink(title: "DQNネーム1-10", topic: .kiranameSet1)

                        PrimaryQuizLink(title: "DQNネーム11-20", topic: .kiranameSet2)

                        PrimaryQuizLink(title: "DQNネーム21-30", topic: .kiranameSet3)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .frame(maxWidth: 560) // iPadで横に広がりすぎない
                }
            }
            // iOS15でも使えるタイトル指定
            .navigationBarTitle("キラキラネームクイズ", displayMode: .inline)
            .onAppear {
                AdsManager.shared.preload()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}