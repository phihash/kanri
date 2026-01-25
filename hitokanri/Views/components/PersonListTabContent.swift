import SwiftUI

struct PersonListTabContent: View {
    let persons: [Person]
    let isSorted: Bool
    let emptyMessage: String?
    let emptyIconName: String?

    init(persons: [Person], isSorted: Bool, emptyMessage: String? = nil, emptyIconName: String? = nil) {
        self.persons = persons
        self.isSorted = isSorted
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
                let filtered = isSorted ? persons.sorted { $0.name < $1.name } : persons
                PersonGridView(persons: filtered)
            }
        }
    }
}
