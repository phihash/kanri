import SwiftUI
import SwiftData

struct Home: View {
    @State private var isSorted : Bool = false
    @State private var addPerson : Bool = false
    @Query private var persons: [Person]
    @Environment(\.modelContext) private var modelContext
    
    var displayPersons: [Person] {
        if isSorted {
            return persons.sorted { $0.name < $1.name }
        } else {
            return persons
        }
    }
    var body: some View {
        NavigationStack{
            ZStack{
                ScrollView(showsIndicators: false){
                    if persons.isEmpty {
                        VStack(spacing: 16){
                            Image(systemName: "person.slash")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)
                            Text("データがありません")
                                .font(.title3)
                        }
                        .padding(.top, 200)
                        
                    } else{
                        LazyVGrid(columns:Array(repeating: .init(.flexible(minimum: 10, maximum: 300)), count: 2)){
                            ForEach(displayPersons){ person in
                                NavigationLink(destination:DetailView(person: person)){
                                    ListSection(person: person)
                                }
                            }
                        }
                       
                    }
                    
                }
                .padding(.vertical,24)
                .navigationTitle(Text("一覧"))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        NavigationLink(destination:SettingsView() , ){
                            Image(systemName: "gear")
                                .foregroundColor(.black)
                        }
                        
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack {
                            Button {
                                isSorted.toggle()
                            } label : {
                                Image("sort")
                                    .foregroundColor(isSorted ? .accentColor : .primary)
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
                Add(addPerson:$addPerson)
            }
        }
    }
}

struct ListSection : View {
    let person: Person
    var body : some View {
        

            VStack{
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.green)
                    .frame(width: 180,height: 108)
                Text(person.name)
                    .foregroundStyle(Color.black)
                    .font(.custom("HiraginoSans-W6", size: 14))
                    .padding(.top,4)
                    .padding(.bottom,10)
            }.overlay(alignment: .topTrailing) {
                Button {
                    person.favorite.toggle()
                } label: {
                    Image(systemName: person.favorite ? "star.fill" : "star")
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                }
                .padding(.top, 8)
                .padding(.trailing, 8)
            }
            
  
        
    }
}

