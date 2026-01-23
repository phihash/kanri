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
                    HStack{
                        TabButton(title: "すべて", isSelected: selectTab == .all) {
                            selectTab = .all
                        }
                        
                        TabButton(title: "お気に入り", isSelected: selectTab == .favorite) {
                            selectTab = .favorite
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    
                    TabView(selection: $selectTab) {
                        ScrollView(showsIndicators: false){
                            if persons.isEmpty {
                                EmptyDataStateView()
                            } else {
                                let filtered = isSorted ? persons.sorted { $0.name < $1.name } : persons
                                PersonGridView(persons: filtered)
                            }
                        }
                        .tag(TabType.all)
                        
                        ScrollView(showsIndicators: false){
                            let favoritePersons = persons.filter { $0.favorite }
                            if favoritePersons.isEmpty {
                                EmptyDataStateView(message: "お気に入りがありません", iconName: "star.slash")
                            } else {
                                let filtered = isSorted ? favoritePersons.sorted { $0.name < $1.name } : favoritePersons
                                PersonGridView(persons: filtered)
                            }
                        }
                        .tag(TabType.favorite)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .toolbar{
                        ToolbarItem(placement: .topBarTrailing) {
                            HomeToolbarButtons(persons: displayPersons, isSorted: $isSorted)
                        }
                    }
                }
                
                Button{
                    addPerson = true
                } label:{
                    Circle().fill(.green)
                        .frame(width: 64,height: 64)
                        .overlay{
                            Image("add")
                                .renderingMode(.template)
                                .foregroundStyle(.white)
                        }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(.trailing,30)
                .padding(.bottom,32)
            }
            .fullScreenCover(isPresented: $addPerson){
                PersonFormView()
            }
        }
    }
}
