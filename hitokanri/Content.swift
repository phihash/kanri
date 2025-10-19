import SwiftUI

struct Content: View {
    @State private var activeTab: TabModel = .home
    @State private var isTabBarHidden : Bool = false
    var body: some View {
        ZStack(alignment: .bottom){
            Group{
                if #available(iOS 18 , *) {
                    TabView(selection: $activeTab){
                        Tab.init(value: .home){
                            Home()
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                        Tab.init(value: .search){
                            Text("Search")
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                        Tab.init(value: .settings){
                            SettingsView()
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                    }
                } else{
                    TabView(selection: $activeTab){
                        Home()
                            .tag(TabModel.home)
                            .background{
                                if !isTabBarHidden{
                                    HideTabBar{
                                        isTabBarHidden = true
                                    }
                                }
                            }
                        
                        Text("search")
                            .tag(TabModel.search)
                        
                        
                        SettingsView()
                            .tag(TabModel.settings)
                        
                    }
                }
            }
            CustomTabBar(activeTab:$activeTab)
        }
    }
}

struct HideTabBar : UIViewRepresentable {
    var result  : () -> ()
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        DispatchQueue.main.async{
            if let tabController = view.tabController {
                tabController.tabBar.isHidden = true
                result()
            }
        }
        
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

extension UIView{
    var tabController: UITabBarController? {
        if let controller = sequence(first: self, next: {
            $0.next
        }).first(where: {$0 is UITabBarController}) as? UITabBarController {
            return controller
        }
        return nil
    }
}

