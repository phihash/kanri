import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack{
            Text("a")
            .navigationTitle(Text("設定"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView()
}
