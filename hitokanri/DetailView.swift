import SwiftUI

struct DetailView: View {
    let person: Person
    var body: some View {
        NavigationStack{
            Text(person.name)
                .navigationTitle(person.name)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
