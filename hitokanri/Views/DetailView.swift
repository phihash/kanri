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
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    editableField(label: "名前", text: $person.name, showDashWhenEmpty: false)
                    
                    editableField(
                        label: "住所",
                        text: Binding(
                            get: { person.address ?? "" },
                            set: { person.address = $0.isEmpty ? nil : $0 }
                        )
                    )
                    
                    editableField(
                        label: "職業",
                        text: Binding(
                            get: { person.occupation ?? "" },
                            set: { person.occupation = $0.isEmpty ? nil : $0 }
                        )
                    )
                    
                    editableField(
                        label: "出身地",
                        text: Binding(
                            get: { person.birthplace ?? "" },
                            set: { person.birthplace = $0.isEmpty ? nil : $0 }
                        )
                    )
                    
                    editableField(
                        label: "関係性",
                        text: Binding(
                            get: { person.relationship ?? "" },
                            set: { person.relationship = $0.isEmpty ? nil : $0 }
                        )
                    )
                    
                    HStack{
                        Toggle(isOn: $person.favorite) {
                            HStack{
                                Image("star")
                                    .renderingMode(.template)
                                Text("お気に入り")
                                    .fontWeight(.semibold)
                            }
                            
                        }
                        Spacer()
                    }
                  
                    
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
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

private extension DetailView {
    @ViewBuilder
    func editableField(label: String, text: Binding<String>, showDashWhenEmpty: Bool = true) -> some View {
        Text(label)
            .font(.headline)
            .foregroundStyle(.secondary)
        if isEditing {
            TextField(label, text: text)
                .font(.title3)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .focused($isFocused)
        } else {
            let value = text.wrappedValue
            Text((value.isEmpty && showDashWhenEmpty) ? "-" : value)
                .font(.title3)
        }
    }
}
