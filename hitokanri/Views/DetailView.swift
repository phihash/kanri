import SwiftUI
import SwiftData

struct DetailView: View {
    @Bindable var person: Person
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var isDeleteDialog = false
    @State private var isEditing = false
    @State private var isExporting = false
    @State private var showCategorySheet = false
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
                    
                    VStack(alignment: .leading) {
                        Text("関係性")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        
                        if isEditing {
                            Button {
                                showCategorySheet = true
                            } label: {
                                HStack {
                                    Text(person.relationship?.isEmpty == false ? person.relationship! : "関係性を選択")
                                        .font(.title3)
                                        .foregroundColor(person.relationship?.isEmpty == false ? .primary : .secondary)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.secondary)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                            }
                        } else {
                            Text(person.relationship?.isEmpty == false ? person.relationship! : "-")
                                .font(.title3)
                        }
                    }
                    
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
                        Button {
                            exportToCSV()
                        } label : {
                            Image(systemName:"square.and.arrow.up")
                                .foregroundStyle(.black)
                        }
                        
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
            .sheet(isPresented: $showCategorySheet) {
                AddCategory(selectedRelationship: Binding(
                    get: { person.relationship ?? "" },
                    set: { person.relationship = $0.isEmpty ? nil : $0 }
                ))
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
    
    func exportToCSV(){
        //まずはヘッダー作成
        let headers = ["名前", "関係性", "住所", "職業", "出身地", "お気に入り"]
        let values = [
            person.name,
            person.relationship ?? "",
            person.address ?? "",
            person.occupation ?? "",
            person.birthplace ?? "",
            person.favorite ? "はい" : "いいえ"
        ]
        let headerLine = headers.joined(separator: ",")
        let valueLine = values.map{"\"\($0)\""}.joined(separator: ",")
        let csvString = headerLine + "\n" + valueLine
        
        let fileName = "\(person.name)_profile.csv"
        
//        iOSでは各アプリに専用のサンドボックス（隔離された領域）があります：
        
//        /var/mobile/Containers/Data/Application/[アプリID]/
//        ├── Documents/     ← ここ！ユーザーファイル保存用
//        ├── Library/       ← アプリ設定ファイル等
//        └── tmp/          ← 一時ファイル
//        
//        - Documents = ユーザーが作成したファイルを保存する場所
//        - iTunesバックアップに含まれる
//        - 他のアプリからはアクセス不可（セキュリティ）
//
//        
//            .userDomainMask     // 現在のユーザー用
//            .localDomainMask    // システム全体用（管理者権限必要）
//            .networkDomainMask  // ネットワーク上
//            .systemDomainMask   // システム専用

        if let documentsPath = FileManager.default.urls(for:.documentDirectory, in:.userDomainMask).first{
            let fileURL = documentsPath.appendingPathComponent(fileName) //安全に結合
            do {
                try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
                let activityVC = UIActivityViewController(
                    activityItems: [fileURL],
                    applicationActivities: nil
                )
                
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController?.present(activityVC, animated: true)
                }


            } catch {
                print("CSV出力エラー")
            }
        }

    }
}
