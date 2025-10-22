import SwiftUI
import SwiftData

struct Add: View {
    @Query private var persons: [Person]
    @Environment(\.modelContext) private var modelContext
    @State var inputName = ""
    @State var furigana = ""
    @State var nickName = ""
    @State var relationship = ""
    @State private var isAlert : Bool = false
    var body: some View {
        NavigationStack {
            ScrollView{
                HStack{
                    Text("名前")
                    TextField("名前を入力してください", text: $inputName)
                        .font(.title3)
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
                Button{
                    if inputName.isEmpty {
                        isAlert = true
                        return
                    }
                    let person = Person(name: inputName,furigana: furigana,nickname: nickName,relationship: relationship)
                    modelContext.insert(person)
                    inputName = ""
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

#Preview {
    Add()
}
