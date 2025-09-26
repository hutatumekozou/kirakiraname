import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("キラキラネームクイズ")
                    .font(.title)
                    .bold()
                Text("1ボタン=10問。全100問を順次追加予定。")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                NavigationLink("スタート（最初の10問）") {
                    Text("ここにクイズ画面を実装していきます。")
                        .padding()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
