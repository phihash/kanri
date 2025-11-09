import SwiftUI
enum TabModel : String,CaseIterable{
    case home = "person"
    case search = "add"
    case settings = "settings"
    
    var title : String{
        switch self {
        case .home: "一覧"
        case .search: "新規作成"
        case .settings: "設定"
        }
    }
}
