import SwiftUI
import SwiftData

enum Field : Hashable {
    case name
    case relationship
    case address
    case occupation
    case birthplace
}

struct Add: View {
    @Query private var persons: [Person]
    @Environment(\.modelContext) private var modelContext
    @State var inputName = ""
    @State var relationship = "友人"
    @State var showingRelationshipSheet = false
    @State var address = ""
    @State var occupation = ""
    @State var birthplace = ""
    @State var favorite = false
    @State private var isAlert : Bool = false
    @FocusState private var focusField: Field?
    @Binding var addPerson: Bool
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false){
                HStack{
                    TextField("名前を入力",text: $inputName)
                        .font(.system(size: 30, weight: .bold))   // LargeTitle相当
                        .textFieldStyle(.plain)
                        .submitLabel(.done)
                        .padding(12)
                        .focused($focusField, equals: .name)
                        .onSubmit {
                            focusField = nil
                        }
                    
                    //                        .textContentType(.organizationName)
                    
                }
                HStack{
                    Image("relationship")
                        .renderingMode(.template)
                    HStack(spacing: 4) {
                        Image(systemName: "gear")
                        Text(relationship)
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.24, minHeight: 40)
                    .background(.red)
                    .cornerRadius(25)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .onTapGesture {
                        showingRelationshipSheet = true
                    }
                    Spacer()
                }
                
                HStack{
                    Image("address")
                        .renderingMode(.template)
                    TextField("住所を入力", text: $address)
                        .font(.headline)
                        .padding(16)
                        .textFieldStyle(.plain)
                        
                        .focused($focusField, equals: .address)
                }
                HStack{
                    Image("work")
                        .renderingMode(.template)
                    TextField("職業を入力", text: $occupation)
                        .font(.headline)
                        .padding(16)
                        .textFieldStyle(.plain)
                        .focused($focusField, equals: .occupation)
                }
                HStack{
                    Image("address")
                        .renderingMode(.template)
                    TextField("出身地を入力", text: $birthplace)
                        .font(.headline)
                        .padding(16)
                        .textFieldStyle(.plain)
                        .focused($focusField, equals: .birthplace)
                }
                HStack{
                    Toggle(isOn: $favorite) {
                        HStack{
                            Image("star")
                                .renderingMode(.template)
                            Text("お気に入り")
                                .fontWeight(.semibold)
                        }
                        
                    }
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                
            }
            .padding(.horizontal)
            .onAppear{
                focusField = .name
            }
            .onTapGesture {
                focusField = nil
            }
            .alert("入力エラー", isPresented: $isAlert) {
                Button("OK") { }
            } message: {
                Text("名前は必須項目です")
            }
            .sheet(isPresented: $showingRelationshipSheet) {
                AddCategory(selectedRelationship: $relationship)
                    .presentationDetents([.fraction(0.6)])
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    HStack{
                        Button("閉じる"){
                            addPerson = false
                        }
                        Button {
                            if inputName.isEmpty {
                                isAlert = true
                                return
                            }
                            let person = Person(
                                name: inputName,
                                relationship: relationship.isEmpty ? nil : relationship,
                                address: address.isEmpty ? nil : address,
                                occupation: occupation.isEmpty ? nil : occupation,
                                birthplace: birthplace.isEmpty ? nil : birthplace,
                                favorite: favorite
                            )
                            modelContext.insert(person)
                            inputName = ""
                            relationship = ""
                            address = ""
                            occupation = ""
                            birthplace = ""
                            favorite = false
                            addPerson = false
                        } label : {
                            Text("保存")
                        }
                    }
                  
                }
            }
            .navigationTitle(Text("新規作成"))
            .navigationBarTitleDisplayMode(.inline)
        }

        
    }
}

    
