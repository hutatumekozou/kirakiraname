import Foundation

class QuizRepository: ObservableObject {
    static let shared = QuizRepository()

    private init() {}

    func loadQuestions(for topic: QuizTopic) -> [Question] {
        var loadedQuestions: [Question] = []
        var source = "unknown"
        var usedFallback = false

        // 1. folder reference → Bundle.main からの読み込みを試行
        if let url = Bundle.main.url(forResource: topic.fileName, withExtension: "json", subdirectory: "questions"),
           let data = try? Data(contentsOf: url),
           let questions = try? JSONDecoder().decode([Question].self, from: data) {
            loadedQuestions = questions
            source = "bundle"
            print("[Repo] set=\(topic.fileName) count=\(loadedQuestions.count) src=bundle fallback=false")
        } else {
            print("[Repo] Failed to load from bundle for \(topic.fileName)")
        }

        // 2. 10問未満の場合は保険データに切り替え
        if loadedQuestions.count < 10 {
            loadedQuestions = createFallbackQuestions(for: topic)
            source = "fallback"
            usedFallback = true
            print("[Repo] set=\(topic.fileName) count=\(loadedQuestions.count) src=fallback fallback=true")
        }

        // 3. 必要に応じて10問に拡張（重複補完）
        if loadedQuestions.count < 10 {
            var expandedQuestions: [Question] = []
            for i in 0..<10 {
                let questionIndex = i % max(loadedQuestions.count, 1)
                if loadedQuestions.indices.contains(questionIndex) {
                    expandedQuestions.append(loadedQuestions[questionIndex])
                }
            }
            loadedQuestions = expandedQuestions
        }

        print("[Repo] set=\(topic.fileName) count=\(loadedQuestions.count) src=\(source) fallback=\(usedFallback)")

        return loadedQuestions.shuffled()
    }

    private func createFallbackQuestions(for topic: QuizTopic) -> [Question] {
        let fallbackQuestions = [
            Question(title: "第1問", question: "福祉住環境コーディネーター2級の基本的な役割はどれか？", choices: ["医療行為を行う", "住環境整備の相談・調整を行う", "介護サービスを提供する", "建築工事を行う"], answerIndex: 1, explanation: "福祉住環境コーディネーター2級は、高齢者・障害者の住環境整備について相談に応じ、各専門職をコーディネートする役割を担います。"),
            Question(title: "第2問", question: "バリアフリーの基本的な考え方はどれか？", choices: ["特別な設備を作る", "障壁を取り除く", "専用施設を作る", "分離して管理する"], answerIndex: 1, explanation: "バリアフリーは、高齢者や障害者等が社会生活をしていく上での物理的、制度的、心理的な障壁（バリア）を取り除くことです。"),
            Question(title: "第3問", question: "介護保険制度で住宅改修費の支給限度額はいくらか？", choices: ["10万円", "20万円", "30万円", "40万円"], answerIndex: 1, explanation: "介護保険制度では、住宅改修費として20万円を上限として、費用の9割（一定以上所得者は8割または7割）が支給されます。"),
            Question(title: "第4問", question: "車いす使用者の通路幅として最低限必要な寸法はどれか？", choices: ["60cm", "75cm", "85cm", "120cm"], answerIndex: 2, explanation: "車いす使用者が通行するために必要な最低限の通路幅は85cmです。ただし、余裕のある設計では90cm以上が望ましいとされます。"),
            Question(title: "第5問", question: "手すりの設置高さとして一般的なのはどれか？", choices: ["65cm", "75cm-85cm", "95cm", "105cm"], answerIndex: 1, explanation: "手すりの設置高さは床から75cm～85cm程度が一般的です。利用者の身長や使用目的に応じて調整が必要です。"),
            Question(title: "第6問", question: "ユニバーサルデザインの特徴はどれか？", choices: ["高齢者専用", "障害者専用", "すべての人が利用可能", "専門家のみ利用可能"], answerIndex: 2, explanation: "ユニバーサルデザインは、年齢や障害の有無、体格、性別、国籍などにかかわらず、できる限り多くの人にとって利用しやすい設計です。"),
            Question(title: "第7問", question: "段差解消の方法として適切でないものはどれか？", choices: ["スロープの設置", "段差プレート", "床のかさ上げ", "段差を大きくする"], answerIndex: 3, explanation: "段差を大きくすることは転倒リスクを高めるため適切ではありません。段差解消にはスロープ設置、段差プレート使用、床のかさ上げなどがあります。"),
            Question(title: "第8問", question: "スロープの勾配として推奨されるのはどれか？", choices: ["1/8以下", "1/12以下", "1/6以下", "制限なし"], answerIndex: 1, explanation: "車いす使用者が自力で昇降できるスロープの勾配は1/12（約8.3%）以下が推奨されます。"),
            Question(title: "第9問", question: "浴室の安全対策として適切なものはどれか？", choices: ["滑りやすい床", "段差の大きい浴槽", "手すりの設置", "暗い照明"], answerIndex: 2, explanation: "浴室では滑り止め対策、手すりの設置、適切な照明、段差の解消などの安全対策が重要です。"),
            Question(title: "第10問", question: "福祉住環境コーディネーターが連携する専門職でないものはどれか？", choices: ["建築士", "理学療法士", "ケアマネジャー", "会計士"], answerIndex: 3, explanation: "福祉住環境コーディネーターは、医師、看護師、理学療法士、作業療法士、ケアマネジャー、建築士、福祉用具専門相談員などと連携しますが、会計士は通常連携対象ではありません。"),
            Question(title: "第11問", question: "高齢者の身体機能変化で正しいものはどれか？", choices: ["聴力向上", "視力調節機能低下", "筋力向上", "平衡感覚向上"], answerIndex: 1, explanation: "加齢により水晶体の弾力性が低下し、近くのものにピントを合わせる調節機能が低下します（老視）。"),
            Question(title: "第12問", question: "認知症の方への住環境整備で重要なことはどれか？", choices: ["複雑な環境", "見当識を支援する環境", "刺激の多い環境", "変化の多い環境"], answerIndex: 1, explanation: "認知症の方には、時間・場所・人の見当識を支援する、分かりやすく一貫した環境づくりが重要です。")
        ]

        return Array(fallbackQuestions.prefix(12))
    }
}