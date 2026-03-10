import SwiftUI
import SwiftData

struct Home: View {
    @State private var addPerson : Bool = false
    @State private var selectTab : TabType = .all
    @State private var searchText : String = ""
    @Query private var persons: [Person]
    @Environment(\.modelContext) private var modelContext
    
    enum TabType {
        case all
        case favorite
    }
    
    var displayPersons: [Person] {
        var filtered = persons

        // 検索フィルタリング
        if !searchText.isEmpty {
            filtered = filtered.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }

        // タブフィルタリング
        if selectTab == .favorite {
            filtered = filtered.filter { $0.favorite }
        }

        return filtered
    }
    var body: some View {
        NavigationStack{
            VStack(spacing: 0){
                Header(persons: displayPersons)
                SearchBar(searchText: $searchText)
                TabBar(selectedTab: $selectTab, tabs: [
                    ("すべて", TabType.all),
                    ("お気に入り", TabType.favorite)
                ])

                TabView(selection: $selectTab) {
                    PersonListTabContent(persons: displayPersons)
                        .tag(TabType.all)

                    PersonListTabContent(
                        persons: displayPersons,
                        emptyMessage: "お気に入りがありません",
                        emptyIconName: "star.slash"
                    )
                    .tag(TabType.favorite)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))

                Spacer()

                BottomActionBar(
                    onAddPerson: {
                        addPerson = true
                    }
                )
            }
            .fullScreenCover(isPresented: $addPerson){
                PersonFormView()
            }
        }
    }
}
