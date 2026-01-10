import Foundation
import SwiftData

@Model
class Person{
    init(name: String,
         relationship: String? = nil,
         address: String? = nil,
         occupation: String? = nil,
         birthplace: String? = nil,
         bloodType : String? = nil,
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
    

    //    var genderStyle: String?            // 性別・ジェンダースタイル・未設定可
    //    var birthday: Date?                 // 誕生日

        var birthplace: String?             // 出身地
    
    
    //
    
    //
    //    // 連絡先
    //    var phoneNumber: String?
    //    var email: String?
    //
        // SNS
        var twitterID: String?
        var instagramID: String?
    
    //    // その他
    //    var notes: String?                  // 備考・メモ
    //
    // お気に入り
    
    //    // 将来的拡張用
    //    var tags: [String]?                 // カスタムタグ・分類
}
