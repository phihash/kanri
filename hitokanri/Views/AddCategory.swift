import SwiftUI

struct AddCategory: View {
    @Binding var selectedRelationship : String
    var body: some View {
        NavigationStack{
            Text("現在選択中の関係は\(selectedRelationship)")
            Text("恋人")
                .onTapGesture {
                    selectedRelationship = "恋人"
                }
            Rectangle()
                .fill(Color.gray)
                .frame(height: 1)
                .padding(.horizontal,12)
            Text("取引先")
                .onTapGesture {
                    selectedRelationship = "取引先"
                }
            Rectangle()
                .fill(Color.gray)
                .frame(height: 1)
                .padding(.horizontal,12)
            .navigationTitle("カテゴリ")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
