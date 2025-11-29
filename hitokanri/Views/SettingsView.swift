import SwiftUI
import StoreKit

struct SettingsView: View {
    @Environment(\.requestReview) private var requestReview
    @State var isShowMailView = false
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
                        Text(Bundle.main.appVersion)
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
                    
                    Button{
                        if MailView.canSendMail() {
                            isShowMailView = true
                        } else {
                            // MailViewを表示できない
                        }
                    } label : {
                        HStack(spacing: 18){
                            Image(systemName: "mail")
                            Text("問い合わせ")
                        }
                        .padding(.vertical,6)
                    }
                    .foregroundStyle(.primary)
                } header : {
                    Text("問い合わせ")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .fontWeight(.bold)
                        .padding(.bottom,12)
                }
                
            }
            .sheet(isPresented: $isShowMailView) {
                MailView(
                    address: ["610g0531@gmail.com"],
                    subject: "問い合わせ",
                    body: "\n\n----\n不具合の検証に利用させていただきます。 \nApp: \(Bundle.main.appName)\n                    Version:  (\(Bundle.main.appVersion))   \n                     iOS: \(UIDevice.current.systemVersion)   \n"
                )
                .edgesIgnoringSafeArea(.all)
            }
            .navigationTitle("設定")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
