import SwiftUI

struct BottomActionBar: View {
    @Binding var isSorted: Bool
    let onAddPerson: () -> Void

    var body: some View {
        HStack(spacing: 24) {
            // 追加ボタン
            Button {
                onAddPerson()
            } label: {
                Image("add")
                    .renderingMode(.template)
                    .foregroundStyle(.black)
                    .frame(width: 44, height: 44)
            }

            // ソートボタン
            Button {
                isSorted.toggle()
            } label: {
                Image("sort")
                    .foregroundColor(isSorted ? .accentColor : .black)
                    .frame(width: 44, height: 44)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(
            Capsule()
                .fill(Color(UIColor.systemGray6))
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
        .padding(.bottom, 20)
    }
}
