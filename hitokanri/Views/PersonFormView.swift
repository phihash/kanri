import SwiftUI
import SwiftData

enum Field : Hashable {
    case name
    case relationship
    case address
    case occupation
    case birthplace
    case phoneNumber
    case email
    case notes
    case twitterID
    case instagramID
}

struct PersonFormView: View {
    @Query private var persons: [Person]
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    // 編集対象のPerson（新規作成時はnil）
    let editingPerson: Person?
    
    // フォームの値
    @State var inputName = ""
    @State var relationship = "友人"
    @State var address = ""
    @State var occupation = ""
    @State var birthplace = ""
    @State var phoneNumber = ""
    @State var email = ""
    @State var notes = ""
    @State var twitterID = ""
    @State var instagramID = ""
    @State var favorite = false
    
    // UI状態
    @State var showingRelationshipSheet = false
    @State private var isAlert : Bool = false
    @State private var isDeleteDialog = false
    @FocusState private var focusField: Field?
    
    // 新規作成かどうか
    var isNewPerson: Bool {
        editingPerson == nil
    }
    
    init(person: Person? = nil) {
        self.editingPerson = person
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false){
                HStack{
                    TextField("名前を入力",text: $inputName)
                        .font(.system(size: 30, weight: .bold))
                        .textFieldStyle(.plain)
                        .submitLabel(.done)
                        .padding(12)
                        .focused($focusField, equals: .name)
                        .onSubmit {
                            focusField = nil
                        }
                }
                
                HStack{
                    Image("relationship")
                        .renderingMode(.template)
                    
                    Text(relationship)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.24, minHeight: 40)
                        .background(.blue)
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
                    Image(systemName: "phone")
                        .renderingMode(.template)
                    TextField("電話番号を入力", text: $phoneNumber)
                        .font(.headline)
                        .padding(16)
                        .textFieldStyle(.plain)
                        .keyboardType(.phonePad)
                        .focused($focusField, equals: .phoneNumber)
                }
                
                HStack{
                    Image(systemName: "envelope")
                        .renderingMode(.template)
                    TextField("メールアドレスを入力", text: $email)
                        .font(.headline)
                        .padding(16)
                        .textFieldStyle(.plain)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .focused($focusField, equals: .email)
                }
                
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: "note.text")
                            .renderingMode(.template)
                        Text("備考・メモ")
                            .font(.headline)
                            .padding(.leading, 4)
                    }
                    .padding(.horizontal, 16)
                    
                    TextEditor(text: $notes)
                        .font(.body)
                        .frame(minHeight: 100)
                        .padding(8)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                        .focused($focusField, equals: .notes)
                }
                .padding(.vertical, 8)
                
                HStack{
                    Image(systemName: "at")
                        .renderingMode(.template)
                    TextField("X(Twitter) IDを入力", text: $twitterID)
                        .font(.headline)
                        .padding(16)
                        .textFieldStyle(.plain)
                        .focused($focusField, equals: .twitterID)
                }
                
                HStack{
                    Image(systemName: "camera")
                        .renderingMode(.template)
                    TextField("Instagram IDを入力", text: $instagramID)
                        .font(.headline)
                        .padding(16)
                        .textFieldStyle(.plain)
                        .focused($focusField, equals: .instagramID)
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
                setupFormData()
                if isNewPerson {
                    focusField = .name
                }
            }
            .onTapGesture {
                focusField = nil
            }
            .alert("入力エラー", isPresented: $isAlert) {
                Button("OK") { }
            } message: {
                Text("名前は必須項目です")
            }
            .alert(isDeleteDialog ? "\(inputName)さんのデータ削除" : "", isPresented: $isDeleteDialog) {
                Button("キャンセル") {
                    isDeleteDialog = false
                }
                Button("OK") {
                    if let person = editingPerson {
                        modelContext.delete(person)
                    }
                    dismiss()
                }
            } message: {
                Text("本当にプロフィールを削除しますか")
            }
            .sheet(isPresented: $showingRelationshipSheet) {
                AddCategory(selectedRelationship: $relationship)
                    .presentationDetents([.fraction(0.65)])
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    HStack{
                        if !isNewPerson {
                            Button {
                                isDeleteDialog = true
                            } label : {
                                Image("delete")
                            }
                        }
                        
                        if isNewPerson {
                            Button("閉じる"){
                                dismiss()
                            }
                        }
                        
                        Button {
                            savePerson()
                        } label : {
                            Text("保存")
                        }
                    }
                }
            }
            .navigationTitle(Text(isNewPerson ? "新規作成" : "編集"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func setupFormData() {
        if let person = editingPerson {
            inputName = person.name
            relationship = person.relationship ?? "友人"
            address = person.address ?? ""
            occupation = person.occupation ?? ""
            birthplace = person.birthplace ?? ""
            phoneNumber = person.phoneNumber ?? ""
            email = person.email ?? ""
            notes = person.notes ?? ""
            twitterID = person.twitterID ?? ""
            instagramID = person.instagramID ?? ""
            favorite = person.favorite
        }
    }
    
    private func savePerson() {
        if inputName.isEmpty {
            isAlert = true
            return
        }
        
        if let person = editingPerson {
            // 編集の場合
            person.name = inputName
            person.relationship = relationship.isEmpty ? nil : relationship
            person.address = address.isEmpty ? nil : address
            person.occupation = occupation.isEmpty ? nil : occupation
            person.birthplace = birthplace.isEmpty ? nil : birthplace
            person.phoneNumber = phoneNumber.isEmpty ? nil : phoneNumber
            person.email = email.isEmpty ? nil : email
            person.notes = notes.isEmpty ? nil : notes
            person.twitterID = twitterID.isEmpty ? nil : twitterID
            person.instagramID = instagramID.isEmpty ? nil : instagramID
            person.favorite = favorite
            try? modelContext.save()
        } else {
            // 新規作成の場合
            let person = Person(
                name: inputName,
                relationship: relationship.isEmpty ? nil : relationship,
                address: address.isEmpty ? nil : address,
                occupation: occupation.isEmpty ? nil : occupation,
                birthplace: birthplace.isEmpty ? nil : birthplace,
                phoneNumber: phoneNumber.isEmpty ? nil : phoneNumber,
                email: email.isEmpty ? nil : email,
                notes: notes.isEmpty ? nil : notes,
                twitterID: twitterID.isEmpty ? nil : twitterID,
                instagramID: instagramID.isEmpty ? nil : instagramID,
                favorite: favorite
            )
            modelContext.insert(person)
        }
        
        dismiss()
    }
    
}
