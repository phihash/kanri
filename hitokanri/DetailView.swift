import SwiftUI
import SwiftData

struct DetailView: View {
    @Bindable var person: Person
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var isDeleteDialog = false
    @State private var isEditing = false
    @FocusState private var isFocused: Bool
    var body: some View {
        NavigationStack{
            VStack{
                Text("名前")
                if isEditing{
                    TextField(person.name, text: $person.name)
                        .font(.title3)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .padding(.horizontal, 24)
                        .focused($isFocused)

                } else {
                    Text(person.name)
                }
              
        
                
                
                Text("名前")
                if isEditing{
                    TextField(person.name, text: $person.name)
                        .font(.title3)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .padding(.horizontal, 24)
                        .focused($isFocused)

                } else {
                    Text(person.name)
                }
                
                Text("名前")
                if isEditing{
                    TextField(person.name, text: $person.name)
                        .font(.title3)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .padding(.horizontal, 24)
                        .focused($isFocused)

                } else {
                    Text(person.name)
                }
            }
                .navigationTitle(person.name)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack{
                            if isEditing {
                                Button {
                                    try? modelContext.save()
                                    isEditing = false
                                } label : {
                                    Text("保存")
                                }
                            } else {
                                Button {
                                    isEditing = true
                                } label : {
                                    Image("edit")
                                }
                            }

                            Button {
                                isDeleteDialog = true
                            } label : {
                                Image("delete")
                            }

                        }
                        
                    }
                }
                .alert("\(person.name)さんのデータ削除",isPresented: $isDeleteDialog) {
                    Button("キャンセル") {
                        isDeleteDialog = false
                    }
                    Button("OK") {
                        modelContext.delete(person)
                        dismiss()
                    }
                } message: {
                    Text("本当にプロフィールを削除しますか")
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("閉じる") {
                            isFocused = false
                        }
                    }
                }
        }
    }
}
