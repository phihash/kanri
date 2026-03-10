import SwiftUI

struct ListSection : View {
    let person: Person
    var body : some View {
        HStack{
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.blue)
                .frame(width: 120,height: 90)
                .overlay(
                    Text("👤")
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                )
            VStack{
                Text(person.name)
                    .foregroundStyle(Color.black)
                    .font(.custom("HiraginoSans-W6", size: 14))
                    .padding(.top,4)
                    .padding(.bottom,10)
                Button {
                    person.favorite.toggle()
                } label: {
                    Image(systemName: person.favorite ? "star.fill" : "star")
                        .font(.system(size: 20))
                        .foregroundStyle(person.favorite ? .yellow : .gray)
                }
                .padding(.top, 8)
                .padding(.trailing, 8)
            }

            Spacer()
        }
    }
}
