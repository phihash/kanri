import SwiftUI

struct EmptyDataStateView: View {
    var message: String = "データがありません"
    var iconName: String = "person.slash"

    var body: some View {
        VStack(spacing: 16){
            Image(systemName: iconName)
                .font(.system(size: 60))
                .foregroundColor(.gray)
            Text(message)
                .font(.title3)
        }
        .padding(.top, 200)
    }
}
