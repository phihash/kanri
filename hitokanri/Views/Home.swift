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
                VStack{
                    HStack{
                        Text("すべて")
                        Text("お気にいり")
                        Spacer()
                    }
                    .padding(.horizontal,12)
                    
                    ScrollView(showsIndicators: false){
                        
                        if persons.isEmpty {
                            EmptyDataStateView()
                        } else{
                            PersonGridView(persons: displayPersons)
                        }
                    }
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
