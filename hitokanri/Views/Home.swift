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
                ScrollView(showsIndicators: false){
                    if persons.isEmpty {
                        EmptyDataStateView()
                    } else{
                        PersonGridView(persons: displayPersons)
                    }
                }
                .padding(.bottom,48)
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack(spacing: 20) {
                            Button {
                                exportAllToCSV()
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
    
    func exportAllToCSV(){
        let headers = ["名前", "関係性", "住所", "職業", "出身地", "電話番号", "メールアドレス", "備考・メモ", "X(Twitter)", "Instagram", "お気に入り"]
        let headerLine = headers.joined(separator: ",")
        
        var csvLines = [headerLine]
        
        for person in displayPersons {
            let values = [
                person.name,
                person.relationship ?? "",
                person.address ?? "",
                person.occupation ?? "",
                person.birthplace ?? "",
                person.phoneNumber ?? "",
                person.email ?? "",
                person.notes ?? "",
                person.twitterID ?? "",
                person.instagramID ?? "",
                person.favorite ? "はい" : "いいえ"
            ]
            let valueLine = values.map{"\"\($0)\""}.joined(separator: ",")
            csvLines.append(valueLine)
        }
        
        let csvString = csvLines.joined(separator: "\n")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
        let fileName = "全員のプロフィール_\(dateFormatter.string(from: Date())).csv"
        
        if let documentsPath = FileManager.default.urls(for:.documentDirectory, in:.userDomainMask).first{
            let fileURL = documentsPath.appendingPathComponent(fileName)
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
