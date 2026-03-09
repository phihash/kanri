import SwiftUI

struct Header: View {
    let persons: [Person]

    var body: some View {
        HStack {
            // 設定ボタン（左端）
            NavigationLink(destination: SettingsView()) {
                Image("settings")
                    .foregroundColor(.black)
                    .frame(width: 44, height: 44)
            }

            Spacer()

            Text("さがす")
                .font(Font.largeTitle)

            Spacer()

            // 共有ボタン（右端）
            Button {
                CSVExporter.exportPersonsToCSV(persons)
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .foregroundStyle(.black)
                    .frame(width: 44, height: 44)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}
