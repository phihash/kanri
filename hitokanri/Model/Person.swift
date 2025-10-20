import Foundation
import SwiftData

@Model
class Person{
    init(name: String,furigana: String? = nil,nickname: String? = nil){
        self.name = name
        if let furigana = furigana{
            self.furigana = furigana
        }
        if let nickname = nickname{
            self.nickname = nickname
        }
    }

    // 基本情報（必須1つのみ）
    var name: String                     // 必須
    var furigana: String?               // フリガナ（任意）
    var nickname: String?               // ニックネーム

//    // プロフィール
//    var genderStyle: String?            // 性別・ジェンダースタイル・未設定可
//    var birthday: Date?                 // 誕生日
//    var bloodType: String?              // 血液型
//    var birthplace: String?             // 出身地
//    var address: String?                // 現住所
//    var occupation: String?             // 職業
//
//    // 関係性など
//    var relationship: String?           // 友人 / 家族 / 同僚 / 推し など自由入力
//    var metCount: Int?                  // 会った回数
//
//    // 連絡先
//    var phoneNumber: String?
//    var email: String?
//
//    // SNS
//    var twitterID: String?
//    var instagramID: String?
//    var facebookID: String?
//
//    // その他
//    var notes: String?                  // 備考・メモ
//
//     var favorite : Bool = false
//    // 将来的拡張用
//    var tags: [String]?                 // カスタムタグ・分類
}
