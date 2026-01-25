import SwiftUI
import SwiftData

struct Home: View {
    @State private var isSorted : Bool = false
    @State private var addPerson : Bool = false
    @State private var selectTab : TabType = .all
    @Query private var persons: [Person]
    @Environment(\.modelContext) private var modelContext
    
    enum TabType {
        case all
        case favorite
    }
    
    var displayPersons: [Person] {
        var filtered = persons
        if selectTab == .favorite {
            filtered = filtered.filter { $0.favorite }
        }
        
        if isSorted {
            return filtered.sorted { $0.name < $1.name }
        } else {
            return filtered
        }
    }
    var body: some View {
        NavigationStack{
            ZStack{
                VStack(spacing: 0){
                    TabBar(selectedTab: $selectTab, tabs: [
                        ("すべて", TabType.all),
                        ("お気に入り", TabType.favorite)
                    ])

                    TabView(selection: $selectTab) {
                        PersonListTabContent(persons: persons, isSorted: isSorted)
                            .tag(TabType.all)

                        PersonListTabContent(
                            persons: persons.filter { $0.favorite },
                            isSorted: isSorted,
                            emptyMessage: "お気に入りがありません",
                            emptyIconName: "star.slash"
                        )
                        .tag(TabType.favorite)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .toolbar{
                        ToolbarItem(placement: .topBarTrailing) {
                            HomeToolbarButtons(persons: displayPersons, isSorted: $isSorted)
                        }
                    }
                }

                FloatingActionButton(iconName: "add", backgroundColor: .black) {
                    addPerson = true
                }
            }
            .fullScreenCover(isPresented: $addPerson){
                PersonFormView()
            }
        }
    }
}
