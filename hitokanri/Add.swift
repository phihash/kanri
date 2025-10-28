import SwiftUI
import SwiftData

struct Add: View {
    @Query private var persons: [Person]
    @Environment(\.modelContext) private var modelContext
    @State var inputName = ""
    @State var furigana = ""
    @State var nickName = ""
    @State var relationship = ""
    @State var address = ""
    @State var occupation = ""
    @State var favorite = false
    @State private var isAlert : Bool = false
    var body: some View {
        NavigationStack {
            ScrollView{
                HStack{
                    TextField("名前を入力",text: $inputName,axis:.vertical)
                        .font(.system(size: 30, weight: .bold))   // LargeTitle相当
                        .textFieldStyle(.plain)
                        .lineLimit(1)
                        .submitLabel(.done)
                        .padding(12)
                    
//                        .textContentType(.organizationName)

                }
                HStack{
                    Text("ふりがな")
                    TextField("名前を入力してください", text: $furigana)
                        .font(.headline)
                        .padding(16)
                        .textFieldStyle(.plain)
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .padding(.horizontal,16)
                                .foregroundColor(.gray.opacity(0.3)),
                            alignment: .bottom
                        )
                }
                HStack{
                    Text("ニックネーム")
                    TextField("名前を入力してください", text: $nickName)
                        .font(.headline)
                        .padding(16)
                        .textFieldStyle(.plain)
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .padding(.horizontal,16)
                                .foregroundColor(.gray.opacity(0.3)),
                            alignment: .bottom
                        )
                }
                HStack{
                    Text("関係性")
                    TextField("名前を入力してください", text: $relationship)
                        .font(.headline)
                        .padding(16)
                        .textFieldStyle(.plain)
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .padding(.horizontal,16)
                                .foregroundColor(.gray.opacity(0.3)),
                            alignment: .bottom
                        )
                }
                HStack{
                    Text("住所")
                    TextField("住所を入力してください", text: $address)
                        .font(.headline)
                        .padding(16)
                        .textFieldStyle(.plain)
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .padding(.horizontal,16)
                                .foregroundColor(.gray.opacity(0.3)),
                            alignment: .bottom
                        )
                }
                HStack{
                    Text("職業")
                    TextField("職業を入力してください", text: $occupation)
                        .font(.headline)
                        .padding(16)
                        .textFieldStyle(.plain)
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .padding(.horizontal,16)
                                .foregroundColor(.gray.opacity(0.3)),
                            alignment: .bottom
                        )
                }
                Toggle(isOn: $favorite) {
                    Text("お気に入り")
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                Button{
                    if inputName.isEmpty {
                        isAlert = true
                        return
                    }
                    let person = Person(
                        name: inputName,
                        furigana: furigana.isEmpty ? nil : furigana,
                        nickname: nickName.isEmpty ? nil : nickName,
                        address: address.isEmpty ? nil : address,
                        occupation: occupation.isEmpty ? nil : occupation,
                        favorite: favorite
                    )
                    modelContext.insert(person)
                    inputName = ""
                    furigana = ""
                    nickName = ""
                    relationship = ""
                    address = ""
                    occupation = ""
                    favorite = false
                } label : {
                    Text("作成")
                        .padding(16)
                        .font(.title2)
                }
                
            }
            .padding(.horizontal)
            .alert("入力エラー", isPresented: $isAlert) {
                Button("OK") { }
            } message: {
                Text("名前は必須項目です")
            }
            
            
            .navigationTitle(Text("新規作成"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
