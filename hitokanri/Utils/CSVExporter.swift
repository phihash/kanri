import Foundation
import UIKit

struct CSVExporter {
    static func exportPersonsToCSV(_ persons: [Person]) {
        let headers = ["名前", "関係性", "職業", "出身地", "電話番号", "メールアドレス", "備考・メモ", "SNS", "お気に入り"]
        let headerLine = headers.joined(separator: ",")

        var csvLines = [headerLine]

        for person in persons {
            // SNS情報を1つの文字列にまとめる
            let snsString = person.socialMedias
                .map { "\($0.platformName): \($0.username)" }
                .joined(separator: ", ")

            let values = [
                person.name,
                person.relationship ?? "",
                person.occupation ?? "",
                person.birthplace ?? "",
                person.phoneNumber ?? "",
                person.email ?? "",
                person.notes ?? "",
                snsString,
                person.favorite ? "はい" : "いいえ"
            ]
            let valueLine = values.map{"\"\($0)\""}.joined(separator: ",")
            csvLines.append(valueLine)
        }

        let csvString = csvLines.joined(separator: "\n")

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
        let fileName = "全員のプロフィール_\(dateFormatter.string(from: Date())).csv"

        if let documentsPath = FileManager.default.urls(for:.documentDirectory, in:.userDomainMask).first{
            let fileURL = documentsPath.appendingPathComponent(fileName)
            do {
                try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
                let activityVC = UIActivityViewController(
                    activityItems: [fileURL],
                    applicationActivities: nil
                )

                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController?.present(activityVC, animated: true)
                }
            } catch {
                print("CSV出力エラー")
            }
        }
    }
}
