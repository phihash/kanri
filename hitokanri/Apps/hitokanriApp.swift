import SwiftUI
import SwiftData
import LocalAuthentication

@main
struct hitokanriApp: App {
    @AppStorage("isPasscodeEnabled") private var isPasscodeEnabled = false
    @State private var isAuthenticated = false
    @State private var isAuthenticating = false
    
  
    private func authenticate() {
        let context = LAContext()
        let reason = "アプリにアクセスするためにパスコードが必要です"
        
        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
            DispatchQueue.main.async {
                if success {
                    isAuthenticated = true
                }
            }
        }
    }
    var body: some Scene {
        WindowGroup {
            if isPasscodeEnabled && !isAuthenticated{
                Text("パスコードが必要です")
                    .onAppear{
                        
                        authenticate()
                        
                    }
            }else{
                Home()
                    .modelContainer(for: Person.self)
                
            }
            
        }
    }
}
