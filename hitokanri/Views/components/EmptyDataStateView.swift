import SwiftUI

struct EmptyDataStateView: View {
    var body: some View {
        VStack(spacing: 16){
            Image(systemName: "person.slash")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            Text("データがありません")
                .font(.title3)
        }
        .padding(.top, 200)
    }
}
