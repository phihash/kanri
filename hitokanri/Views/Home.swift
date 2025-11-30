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
                        ForEach(displayPersons){ person in
                            NavigationLink(destination:DetailView(person: person)){
                                ListSection(person: person)
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
        HStack{
            VStack{
                VStack(alignment: .leading,spacing: 6){
                    Text(person.name)
                        .font(.custom("HiraginoSans-W6", size: 20))
                    if let relationship = person.relationship, !relationship.isEmpty {
                        Text(relationship)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }

            Group{
                if person.favorite{
                    Button {
                        person.favorite.toggle()
                    } label: {
                        Image(systemName: "star.fill")
                    }
                }else{
                    Button{
                        person.favorite.toggle()
                    } label :{
                        Image("star")
                    }
                }
            }            
        }
        .padding(.horizontal,18)
        .padding(.vertical,12)
        .background(Color.black.opacity(0.1))
        .cornerRadius(12)
        .padding(.horizontal,12)
    }
}

