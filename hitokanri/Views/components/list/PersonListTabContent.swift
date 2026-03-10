import SwiftUI

struct PersonListTabContent: View {
    let persons: [Person]
    let emptyMessage: String?
    let emptyIconName: String?

    init(persons: [Person], emptyMessage: String? = nil, emptyIconName: String? = nil) {
        self.persons = persons
        self.emptyMessage = emptyMessage
        self.emptyIconName = emptyIconName
    }

    var body: some View {
        ScrollView(showsIndicators: false){
            if persons.isEmpty {
                EmptyDataStateView(
                    message: emptyMessage ?? "データがありません",
                    iconName: emptyIconName ?? "person.slash"
                )
            } else {
                PersonGridView(persons: persons)
            }
        }
    }
}
