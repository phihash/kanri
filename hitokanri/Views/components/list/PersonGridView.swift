import SwiftUI

struct PersonGridView: View {
    let persons: [Person]

    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: 12){
            ForEach(persons){ person in
                NavigationLink(destination:PersonFormView(person: person)){
                    ListSection(person: person)
                }
            }
        }
        .padding(.horizontal, 12)
    }
}
