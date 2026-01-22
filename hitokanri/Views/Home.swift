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
                        Button {
                            selectTab = .all
                        } label: {
                            VStack(spacing: 8) {
                                Text("すべて")
                                    .font(.system(size: 16, weight: selectTab == .all ? .semibold : .regular))
                                    .foregroundColor(selectTab == .all ? .black : .gray)

                                Rectangle()
                                    .fill(selectTab == .all ? Color.accentColor : Color.clear)
                                    .frame(height: 2)
                            }
                        }

                        Button {
                            selectTab = .favorite
                        } label: {
                            VStack(spacing: 8) {
                                Text("お気に入り")
                                    .font(.system(size: 16, weight: selectTab == .favorite ? .semibold : .regular))
                                    .foregroundColor(selectTab == .favorite ? .black : .gray)

                                Rectangle()
                                    .fill(selectTab == .favorite ? Color.accentColor : Color.clear)
                                    .frame(height: 2)
                            }
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
                            HStack(spacing: 20) {
                                Button {
                                    CSVExporter.exportPersonsToCSV(displayPersons)
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
