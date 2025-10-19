import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                Text("設定")
            }
            .navigationTitle(Text("設定"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView()
}
