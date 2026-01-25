import SwiftUI

struct PersonGridView: View {
    let persons: [Person]

    var body: some View {
        LazyVGrid(columns:Array(repeating: .init(.flexible(minimum: 10, maximum: 300)), count: 2)){
            ForEach(persons){ person in
                NavigationLink(destination:PersonFormView(person: person)){
                    ListSection(person: person)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}
