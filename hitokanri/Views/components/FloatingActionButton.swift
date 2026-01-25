import SwiftUI

struct FloatingActionButton: View {
    let iconName: String
    let backgroundColor: Color
    let action: () -> Void

    var body: some View {
        Button{
            action()
        } label:{
            Circle().fill(backgroundColor)
                .frame(width: 64, height: 64)
                .overlay{
                    Image(iconName)
                        .renderingMode(.template)
                        .foregroundStyle(.white)
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .padding(.trailing, 30)
        .padding(.bottom, 32)
    }
}
