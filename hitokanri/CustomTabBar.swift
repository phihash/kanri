import SwiftUI

struct CustomTabBar: View {
    @Binding var activeTab : TabModel
    var activeForeground : Color = .white
    var activeBackground : Color = .blue
    var body: some View {
        HStack(spacing:8){
            ForEach(TabModel.allCases, id: \.self){ tab in
                Button{
                    activeTab = tab
                } label: {
                    HStack(spacing: 8){
                        Image(tab.rawValue)
                            .renderingMode(.template)
                            .font(.title3)
                            .frame(width: 24,height: 24)
                        
                        if activeTab == tab {
                            Text(tab.title)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .font(.custom("HiraginoSans-W6", size:14))

                        }
                    }
                    .foregroundStyle(activeTab == tab ? activeForeground  : .gray)
                    .padding(.vertical,12)
                    .padding(.leading,18)
                    .padding(.trailing,24)
                    .contentShape(.rect)
                    .background{
                        if activeTab == tab{
                            Capsule()
                                .fill(activeBackground.gradient)
                        }
                    }
                    
                }
            }
        }
        .padding(.bottom,18)
        .animation(.smooth(duration: 0.3,extraBounce: 0),value:activeTab)
    }
}
