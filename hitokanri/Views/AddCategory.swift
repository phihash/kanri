import SwiftUI

struct AddCategory: View {
    @Binding var selectedRelationship : String
    let closeRelationship = ["友人","家族", "恋人"]
    let workRelationship = ["先輩", "後輩", "同僚","取引先","元同僚"]
    let otherRelationship = ["そのほか"]
    
    var body: some View {
        NavigationStack{
            
            HStack{
                Text("身近な人")
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal,16)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 8) {
                ForEach(closeRelationship ,id: \.self){ relationship in
                    Text(relationship)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.24, minHeight: 40)
                        .background(selectedRelationship == relationship ? .blue : .gray)
                        .cornerRadius(25)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .onTapGesture {
                            selectedRelationship = relationship
                        }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom,16)
            
            Rectangle()
                .fill(Color.gray)
                .frame(height: 1)
                .padding(.horizontal,12)
            
            HStack{
                Text("仕事関係")
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal,16)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 8) {
                ForEach(workRelationship ,id: \.self){ relationship in
                    Text(relationship)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.24, minHeight: 40)
                        .background(selectedRelationship == relationship ? .blue : .gray)
                        .cornerRadius(25)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .onTapGesture {
                            selectedRelationship = relationship
                        }
                }
            }
            .padding(.horizontal, 16)
            
            Rectangle()
                .fill(Color.gray)
                .frame(height: 1)
                .padding(.horizontal,12)
            
            HStack{
                Text("そのほか")
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal,16)
            .padding(.bottom,16)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 8) {
                ForEach(otherRelationship ,id: \.self){ relationship in
                    Text(relationship)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.24, minHeight: 40)
                        .background(selectedRelationship == relationship ? .blue : .gray)
                        .cornerRadius(25)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .onTapGesture {
                            selectedRelationship = relationship
                        }
                }
            }
            .padding(.horizontal, 16)
            
            .navigationTitle("カテゴリ")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
