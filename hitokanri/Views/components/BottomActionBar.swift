import SwiftUI

struct BottomActionBar: View {
    let onAddPerson: () -> Void

    var body: some View {
        HStack {
            Spacer()

            Button {
                onAddPerson()
            } label: {
                Image("add")
                    .renderingMode(.template)
                    .foregroundStyle(.black)
                    .frame(width: 44, height: 44)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .background(
                Capsule()
                    .fill(Color(UIColor.systemGray6))
                    .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
            )
        }
        .padding(.trailing, 20)
        .padding(.bottom, 20)
    }
}
