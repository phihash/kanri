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
         address: String? = nil,
         occupation: String? = nil,
         birthplace: String? = nil,
         bloodType : String? = nil,
         phoneNumber: String? = nil,
         email: String? = nil,
         notes: String? = nil,
         twitterID: String? = nil,
         instagramID: String? = nil,
         favorite: Bool = false){
        self.name = name
        if let relationship = relationship {
            self.relationship = relationship
        }
        if let address = address {
            self.address = address
        }
        if let occupation = occupation {
            self.occupation = occupation
        }
        if let birthplace = birthplace {
            self.birthplace = birthplace
        }
        if let phoneNumber = phoneNumber {
            self.phoneNumber = phoneNumber
        }
        if let email = email {
            self.email = email
        }
        if let notes = notes {
            self.notes = notes
        }
        if let twitterID = twitterID {
            self.twitterID = twitterID
        }
        if let instagramID = instagramID {
            self.instagramID = instagramID
        }
        
        self.favorite = favorite
    }
    
    // 基本情報（必須1つのみ）
    var name: String                     // 必須
    var relationship: String?           // 友人 / 家族 / 同僚 / 推し など自由入力
    var address: String?                // 住所
    var occupation: String?             // 職業
    var favorite: Bool = false
  
    var birthplace: String?             // 出身地
    
    // 連絡先
    var phoneNumber: String?
    var email: String?
    var notes: String?                  // 備考・メモ
    
    // SNS（旧）
    var twitterID: String?
    var instagramID: String?

    // SNS（新：配列で管理）
    var socialMedias: [SocialMedia] = []

}
