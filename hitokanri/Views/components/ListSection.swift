import SwiftUI

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
