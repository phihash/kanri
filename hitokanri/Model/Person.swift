import Foundation
import SwiftData

// SNS情報を管理する構造体
struct SocialMedia: Codable, Identifiable {
    var id = UUID()
    var platformName: String  // SNS名（自由入力）
    var username: String      // ユーザー名/ID

    // よく使うSNSのプリセット（UI表示用）
    static let commonPlatforms = [
        "X (Twitter)",
        "Instagram",
        "Facebook",
        "TikTok",
        "LinkedIn",
        "YouTube",
        "Bluesky",
        "Threads"
    ]
}

@Model
class Person{
    init(name: String,
         relationship: String? = nil,
         occupation: String? = nil,
         birthplace: String? = nil,
         phoneNumber: String? = nil,
         email: String? = nil,
         notes: String? = nil,
         favorite: Bool = false,
         socialMedias: [SocialMedia] = []) {
        self.name = name
        self.relationship = relationship
        self.occupation = occupation
        self.birthplace = birthplace
        self.phoneNumber = phoneNumber
        self.email = email
        self.notes = notes
        self.favorite = favorite
        self.socialMedias = socialMedias
    }
    
    // 基本情報（必須1つのみ）
    var name: String                     // 必須
    var relationship: String?           // 友人 / 家族 / 同僚 / 推し など自由入力
    var occupation: String?             // 職業
    var favorite: Bool = false

    var birthplace: String?             // 出身地
    
    // 連絡先
    var phoneNumber: String?
    var email: String?
    var notes: String?                  // 備考・メモ

    // SNS
    var socialMedias: [SocialMedia] = []

}
