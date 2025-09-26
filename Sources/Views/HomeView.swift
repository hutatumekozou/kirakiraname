import SwiftUI

struct HomeView: View {
    private let columns = [GridItem(.flexible())]

    var body: some View {
        NavigationView {
            ZStack {
                // グラデーション背景
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.6, green: 0.8, blue: 1.0),
                        Color(red: 0.4, green: 0.6, blue: 0.9)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // タイトルセクション
                    VStack(spacing: 8) {
                        Text("福祉住環境")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("コーディネーター2級")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("問題集")
                            .font(.system(size: 48, weight: .bold))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    .padding(.top, 40)
                    
                    // クイズボタングリッド
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(QuizTopic.allCases) { topic in
                                NavigationLink(destination: QuizView(topic: topic)) {
                                    Text(topic.title)
                                        .font(.headline)
                                        .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.8))
                                        .frame(maxWidth: .infinity, minHeight: 72)
                                        .background(Color.white)
                                        .cornerRadius(16)
                                        .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                AdsManager.shared.preload()
            }
        }
    }
}