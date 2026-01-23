import SwiftUI

struct HomeToolbarButtons: View {
    let persons: [Person]
    @Binding var isSorted: Bool

    var body: some View {
        HStack(spacing: 20) {
            Button {
                CSVExporter.exportPersonsToCSV(persons)
            } label : {
                Image(systemName:"square.and.arrow.up")
                    .foregroundStyle(.black)
            }

            Button {
                isSorted.toggle()
            } label : {
                Image("sort")
                    .foregroundColor(isSorted ? .accentColor : .primary)
            }

            NavigationLink(destination:SettingsView()){
                Image("settings")
                    .foregroundColor(.black)
            }
        }
    }
}
