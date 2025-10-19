import SwiftUI

struct Home: View {
    @State private var mode : String = "list"
    var body: some View {
        NavigationStack{
            ScrollView{
                
                if mode == "list"{
                    ListSection()
                }else{
                    SquareSection()
                }
                
            }
            .padding(.top,24)
            .navigationTitle(Text("一覧"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    if mode == "list"{
                        Button {
                            mode = "square"
                        } label : {
                            Image("square")
                        }
                    }else{
                        Button {
                            mode = "list"
                        } label : {
                            Image("list")
                        }
                    }
                }
            }
        }
    }
}

struct ListSection : View {
    var body : some View {
        HStack{
            Circle()
                .fill(.gray)
                .frame(width: 56, height: 56)
                .overlay {
                    Image(systemName: "person")
                        .font(.title)
                }
            
            VStack(alignment: .leading,spacing: 12){
                Text("吉澤要人")
                    .font(.custom("HiraginoSans-W6", size: 20))
                Text("吉澤要人")
                    .font(.custom("HiraginoSans-W6", size: 12))
            }
            .padding(.leading,8)
            Spacer()
        }
        .padding(.horizontal,18)
        .padding(.vertical,12)
        .background(Color.black.opacity(0.1))
        .cornerRadius(12)
        .padding(.horizontal,12)
    }
}

struct SquareSection : View {
    var body: some View {
        VStack(spacing: 12){
            Circle()
                .fill(.gray)
                .frame(width: 56, height: 56)
                .overlay {
                    Image(systemName: "person")
                        .font(.title)
                }
            Text("吉澤要人")
                .font(.custom("HiraginoSans-W6", size: 16))
        }
        .padding(.horizontal,18)
        .padding(.vertical,12)
        .background(Color.black.opacity(0.1))
        .cornerRadius(12)
        .padding(.horizontal,12)
    }
}


#Preview {
    Home()
}
