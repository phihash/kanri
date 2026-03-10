import SwiftUI

struct TabBar<TabType: Equatable>: View {
    @Binding var selectedTab: TabType
    let tabs: [(title: String, tab: TabType)]

    var body: some View {
        HStack{
            ForEach(tabs.indices, id: \.self) { index in
                TabButton(title: tabs[index].title, isSelected: selectedTab == tabs[index].tab) {
                    selectedTab = tabs[index].tab
                }
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}
