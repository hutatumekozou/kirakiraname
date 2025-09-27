import SwiftUI

struct HomeStarPatternView: View {
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

                // 星の装飾
                HomeStarPatternView()
                    .ignoresSafeArea()

                // コンテンツ本体（縦スクロール可能）
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVStack(spacing: 12) {
                        // 新タイトル（2行目は先頭に半角スペース2つ）
                        Text("🌟 キラキラ🌟\n  ネームクイズ")
                            .font(.system(size: 46, weight: .heavy))   // 66 × 0.7 = 46pt
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .padding(.top, -40)                         // 位置は現状のまま
                        .padding(.top, 60)
                        .padding(.bottom, 20)
                        // 9つのクイズボタン
                        PrimaryQuizLink(title: "人気キラキラネーム-1", topic: .kiranameSet6)

                        PrimaryQuizLink(title: "人気キラキラネーム-2", topic: .kiranameSet7)

                        PrimaryQuizLink(title: "人気キラキラネーム-3", topic: .kiranameSet6_2)

                        PrimaryQuizLink(title: "女の子キラキラネーム 1-10", topic: .kiranameSet1)

                        PrimaryQuizLink(title: "女の子キラキラネーム 11-20", topic: .kiranameSet2)

                        PrimaryQuizLink(title: "女の子キラキラネーム 21-30", topic: .kiranameSet3)

                        PrimaryQuizLink(title: "男の子キラキラネーム1-10", topic: .boyKiraname1)

                        PrimaryQuizLink(title: "男の子キラキラネーム11-20", topic: .boyKiraname2)

                        PrimaryQuizLink(title: "男の子キラキラネーム21-30", topic: .boyKiraname3)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 40)    // 最下部がホームバーに隠れないよう余白
                    .frame(maxWidth: 560) // iPadで横に広がりすぎない
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                AdsManager.shared.preload()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}