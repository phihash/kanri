import SwiftUI

struct Header: View {
    let persons: [Person]

    var body: some View {
        HStack {
            NavigationLink(destination: SettingsView()) {
                Image("settings")
                    .foregroundColor(.black)
                    .frame(width: 44, height: 44)
            }

            Text("さがす")
                .fontWeight(.bold)
                .font(.title2)

            Spacer()

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
