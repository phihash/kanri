import SwiftUI
import StoreKit

struct SettingsView: View {
    @Environment(\.requestReview) private var requestReview
    @AppStorage("isPasscodeEnabled") private var isPasscodeEnabled = false
    var body: some View {
        NavigationStack{
            List{
                Section{
                    HStack{
                        HStack(spacing: 18){
                            Image(systemName: "tag")
                            Text("現在のバージョン")
                        }
                        Spacer()
                        Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "バージョンを取得できませんでした")
                    }
                    .foregroundStyle(.primary)
                    .padding(.vertical,6)
                    
                    HStack{
                        HStack(spacing: 18){
                            Image(systemName: "key")
                            Text("パスコード")
                        }
                        Spacer()
                        Toggle(isOn: $isPasscodeEnabled) {}
                    }
                    .foregroundStyle(.primary)
                    .padding(.vertical,6)
                    
                    HStack(spacing: 12){
                        ShareLink(item: URL(string: "https://apps.apple.com/jp/app/%E3%83%92%E3%83%88%E3%83%AD%E3%82%B0/id6754248786")!) {
                            HStack(spacing: 18){
                                Image(systemName: "star.fill")
                                Text("アプリを共有する")
                            }
                        }
                        .foregroundStyle(.primary)
                    }
                    
                    Button{
                        requestReview()
                    } label : {
                        HStack(spacing: 18){
                            Image(systemName: "star")
                            Text("アプリを評価する")
                        }
                        .padding(.vertical,6)
                    }
                    .foregroundStyle(.primary)
                } header : {
                    Text("アプリ")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .fontWeight(.bold)
                        .padding(.bottom,12)
                }
                
                Section{
                    
                    HStack(spacing: 18){
                        Image(systemName: "note")
                        Link("プライバシーポリシー",destination: URL(string: "https://sizu.me/maili/posts/mizz2k36rmub")!)
                            .foregroundStyle(.primary)
                    }
                    .padding(.vertical,6)
                    
                    HStack(spacing: 18){
                        Image(systemName: "note")
                        Link("利用規約",destination: URL(string: "https://sizu.me/maili/posts/vhdvwzov5vtb")!)
                            .foregroundStyle(.primary)
                    }
                    .padding(.vertical,6)
                    
                    
                } header: {
                    Text("ポリシーと規約")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .fontWeight(.bold)
                        .padding(.bottom,12)
                }
                
                Section{
                    
                    HStack(spacing: 18){
                        Image(systemName: "mail")
                        Link("匿名でお問い合わせ",destination: URL(string: "https://forms.gle/QXGBLSkKxgPpZyhYA")!)
                            .foregroundStyle(.primary)
                    }
                    .padding(.vertical,6)
             
                } header : {
                    Text("問い合わせ")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .fontWeight(.bold)
                        .padding(.bottom,12)
                }

            }
            .navigationTitle("設定")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
