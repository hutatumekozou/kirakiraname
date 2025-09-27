import SwiftUI

struct ResultStarPatternView: View {
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

struct ResultView: View {
    let topic: QuizTopic
    let correctAnswers: Int
    let totalQuestions: Int
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    private var scorePercentage: Double {
        Double(correctAnswers) / Double(totalQuestions) * 100
    }
    
    private var resultMessage: String {
        switch Int(scorePercentage) {
        case 0:
            return "【奇跡の0！】 逆にレアかも！😂✨ 推しネームは見つからなかったけど、ここからがドラマの始まりだよ！"
        case 10:
            return "【かすかに光る✨】 まず1問クリア、おめでとう！この1問はきっと「超難関」ネーム。次こそはトレンド入りネームを狙おう！"
        case 20:
            return "【もったいなーい！】 あとちょっとで読めてたはず！🥺 もうすぐ流行ネームの読み方がわかるよ。次こそは「わかる！」ってスッキリしちゃおう！"
        case 30:
            return "【センスの予感！】 3割正解はすごい！もうキラキラネームの「あるあるパターン」が見えてきたはず！この調子で読解力UPしちゃお！"
        case 40:
            return "【もうすぐ半分💖】 あと一歩で折り返し！ここまで来たら、残りの問題もぜ〜んぶ読めちゃう気がしない？ファイト！"
        case 50:
            return "【推し認定レベル！🏅】 ちょうど半分クリア、神すぎ！✨ 難読ネームを半分読破って、結構な特技だよ。ここからもっと正解率を爆上げしよ！"
        case 60:
            return "【ネーム通すぎる件。】 半分以上正解は天才！もはやあなたは「名付けのプロ」か「難読ネーム評論家」！このままGO！"
        case 70:
            return "【めっちゃいい感じ！】 7割正解ってすごすぎ！もう誰も読めないネームもスラスラ読めちゃうレベル。自信持って、満点目指して！"
        case 80:
            return "【あと少しでカンペキ！】 素晴らしい結果！✨ もう「読めないネームはない」と言っても過言じゃない！満点まであと少しの努力を！"
        case 90:
            return "【惜しすぎる！😭】 ほぼ満点、悔しいー！でもこの正解率はレジェンド級。次のチャレンジでは絶対100点満点とっちゃおう！"
        case 100:
            return "【🎉全問読破！最強の読解力！🎉】 満点おめでとう！🙌💕 キラキラネームを完全攻略！あなたはもう、難読ネームに迷わない「最強ネームマスター」だよ！"
        default:
            // その他の値（1-9, 11-19, 21-29, 31-39, 41-49, 51-59, 61-69, 71-79, 81-89, 91-99）
            switch scorePercentage {
            case 1...9:
                return "【奇跡の0！】 逆にレアかも！😂✨ 推しネームは見つからなかったけど、ここからがドラマの始まりだよ！"
            case 11...19:
                return "【かすかに光る✨】 まず1問クリア、おめでとう！この1問はきっと「超難関」ネーム。次こそはトレンド入りネームを狙おう！"
            case 21...29:
                return "【もったいなーい！】 あとちょっとで読めてたはず！🥺 もうすぐ流行ネームの読み方がわかるよ。次こそは「わかる！」ってスッキリしちゃおう！"
            case 31...39:
                return "【センスの予感！】 3割正解はすごい！もうキラキラネームの「あるあるパターン」が見えてきたはず！この調子で読解力UPしちゃお！"
            case 41...49:
                return "【もうすぐ半分💖】 あと一歩で折り返し！ここまで来たら、残りの問題もぜ〜んぶ読めちゃう気がしない？ファイト！"
            case 51...59:
                return "【推し認定レベル！🏅】 ちょうど半分クリア、神すぎ！✨ 難読ネームを半分読破って、結構な特技だよ。ここからもっと正解率を爆上げしよ！"
            case 61...69:
                return "【ネーム通すぎる件。】 半分以上正解は天才！もはやあなたは「名付けのプロ」か「難読ネーム評論家」！このままGO！"
            case 71...79:
                return "【めっちゃいい感じ！】 7割正解ってすごすぎ！もう誰も読めないネームもスラスラ読めちゃうレベル。自信持って、満点目指して！"
            case 81...89:
                return "【あと少しでカンペキ！】 素晴らしい結果！✨ もう「読めないネームはない」と言っても過言じゃない！満点まであと少しの努力を！"
            case 91...99:
                return "【惜しすぎる！😭】 ほぼ満点、悔しいー！でもこの正解率はレジェンド級。次のチャレンジでは絶対100点満点とっちゃおう！"
            default:
                return "【奇跡の0！】 逆にレアかも！😂✨ 推しネームは見つからなかったけど、ここからがドラマの始まりだよ！"
            }
        }
    }
    
    private var illustrationColor: Color {
        switch scorePercentage {
        case 81...100:
            return Color.green
        case 61...80:
            return Color.blue
        case 41...60:
            return Color.orange
        case 21...40:
            return Color.purple
        default: // 0-20%
            return Color.pink
        }
    }
    
    var body: some View {
        ZStack {
            // 桃色背景
            Color(red: 1.0, green: 0.75, blue: 0.8)
                .ignoresSafeArea()

            // 星の装飾
            ResultStarPatternView()
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // タイトル
                Text("クイズ結果")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                // トピック名
                Text(topic.title)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                // スコア表示
                VStack(spacing: 15) {
                    Text("\(correctAnswers) / \(totalQuestions)")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text(String(format: "%.0f%%", scorePercentage))
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(20)
                
                // イラストと激励メッセージエリア
                VStack(spacing: 15) {
                    // メッセージ
                    Text(resultMessage)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    // 可愛いキャラクターイラスト風
                    ZStack {
                        // カラフルな背景（キラキラ効果）
                        RoundedRectangle(cornerRadius: 15)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.pink.opacity(0.3),
                                        Color.purple.opacity(0.3),
                                        Color.blue.opacity(0.3)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 180, height: 180)

                        VStack(spacing: 8) {
                            // 可愛いキャラクター
                            HStack(spacing: 4) {
                                Image(systemName: "sparkles")
                                    .font(.system(size: 16))
                                    .foregroundColor(.yellow)
                                Image(systemName: "person.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.purple)
                                Image(systemName: "sparkles")
                                    .font(.system(size: 16))
                                    .foregroundColor(.yellow)
                            }

                            // ハートやユニコーンのアクセント
                            HStack(spacing: 12) {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.pink)
                                Image(systemName: "star.fill")
                                    .font(.system(size: 18))
                                    .foregroundColor(.yellow)
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.pink)
                            }
                        }
                        .frame(width: 180, height: 180)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(20)
                .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                
                Spacer()
                
                // ボタン
                Button(action: {
                    // 広告表示後に確実に初期画面（メニュー）に戻る
                    AdsManager.shared.showInterstitialAndReturnToRoot()
                }) {
                    Text("最初に戻る")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color(red: 0.2, green: 0.4, blue: 0.8))
                        .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}