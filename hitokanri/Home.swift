import SwiftUI
import SwiftData

struct Home: View {
    @State private var mode : String = "list"
    @Query private var persons: [Person]
    @Environment(\.modelContext) private var modelContext
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationStack{
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
                    if mode == "list"{
                        ForEach(persons){ person in
                            NavigationLink(destination:DetailView(person: person)){
                                ListSection(person: person)
                            }
                        }
                        
                    }else{
                        LazyVGrid(columns: columns){
                            ForEach(persons){ person in
                                NavigationLink(destination:DetailView(person: person)){
                                    SquareSection(person: person)
                                }
                            }
                        }
                        .padding(.horizontal,18)
                        
                    }
                }
                
            }
            .padding(.vertical,24)
            .navigationTitle(Text("一覧"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    if mode == "list"{
                        Button {
                            mode = "square"
                        } label : {
                            Image("square")
                        }
                    }else{
                        Button {
                            mode = "list"
                        } label : {
                            Image("list")
                        }
                    }
                }
            }
        }
    }
}

struct ListSection : View {
    let person: Person
    var body : some View {
        HStack{
            Circle()
                .fill(.gray)
                .frame(width: 56, height: 56)
                .overlay {
                    Image(systemName: "person")
                        .font(.title)
                }
            
            VStack(alignment: .leading,spacing: 12){
                Text(person.name)
                    .font(.custom("HiraginoSans-W6", size: 20))
                //                Text("吉澤要人")
                //                    .font(.custom("HiraginoSans-W6", size: 12))
            }
            .padding(.leading,8)
            Spacer()
        }
        .padding(.horizontal,18)
        .padding(.vertical,12)
        .background(Color.black.opacity(0.1))
        .cornerRadius(12)
        .padding(.horizontal,12)
    }
}

struct SquareSection : View {
    let person: Person
    var body: some View {
        VStack(spacing: 12){
            Circle()
                .fill(.gray)
                .frame(width: 56, height: 56)
                .overlay {
                    Image(systemName: "person")
                        .font(.title)
                }
            Text(person.name)
                .font(.custom("HiraginoSans-W6", size: 12))
        }
        .padding(.horizontal,8)
        .padding(.vertical,12)
        .cornerRadius(12)
    }
}


#Preview {
    Home()
}
