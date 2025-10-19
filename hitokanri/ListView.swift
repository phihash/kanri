import SwiftUI

struct ListView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                
                HStack{
                    Image(systemName: "person")
                    Text("吉澤要人")
                }
                
                Text("一覧")
                    .font(.headline)
            }
                .navigationTitle(Text("一覧"))
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ListView()
}
