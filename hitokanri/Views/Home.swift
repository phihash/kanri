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
                        VStack(spacing: 16){
                            Image(systemName: "person.slash")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)
                            Text("データがありません")
                                .font(.title3)
                        }
                        .padding(.top, 200)
                        
                    } else{
                        LazyVGrid(columns:Array(repeating: .init(.flexible(minimum: 10, maximum: 300)), count: 2)){
                            ForEach(displayPersons){ person in
                                NavigationLink(destination:PersonFormView(person: person)){
                                    ListSection(person: person)
                                }
                            }
                        }
                    }
                    
                }
                .padding(.vertical,24)
                .navigationTitle(Text("一覧"))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        NavigationLink(destination:SettingsView()){
                            Image("settings")
                                .foregroundColor(.black)
                        }
                        
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack {
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
        let headers = ["名前", "関係性", "住所", "職業", "出身地", "X(Twitter)", "Instagram", "お気に入り"]
        let headerLine = headers.joined(separator: ",")
        
        var csvLines = [headerLine]
        
        for person in displayPersons {
            let values = [
                person.name,
                person.relationship ?? "",
                person.address ?? "",
                person.occupation ?? "",
                person.birthplace ?? "",
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

struct ListSection : View {
    let person: Person
    var body : some View {
            VStack{
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.blue)
                    .frame(width: 180,height: 108)
                    .overlay(
                        Text("👤")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                    )
                Text(person.name)
                    .foregroundStyle(Color.black)
                    .font(.custom("HiraginoSans-W6", size: 14))
                    .padding(.top,4)
                    .padding(.bottom,10)
            }.overlay(alignment: .topTrailing) {
                Button {
                    person.favorite.toggle()
                } label: {
                    Image(systemName: person.favorite ? "star.fill" : "star")
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                }
                .padding(.top, 8)
                .padding(.trailing, 8)
            }
        
    }
}

