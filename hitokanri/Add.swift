import SwiftUI
import SwiftData

struct Add: View {
    @Query private var persons: [Person]
    @Environment(\.modelContext) private var modelContext
    @State var inputName = ""
    var body: some View {
        NavigationStack {
            TextField("名前を入力してください", text: $inputName)
                .font(.title3)
                .padding()
                .border(Color.gray)
                .padding()
            Button("臨時"){
                if inputName.isEmpty {
                    return
                }
                let person = Person(name: inputName)
                modelContext.insert(person)
                inputName = ""
            }
            .navigationTitle(Text("新規作成"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    Add()
}
