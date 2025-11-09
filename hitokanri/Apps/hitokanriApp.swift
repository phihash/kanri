import SwiftUI
import SwiftData

@main
struct hitokanriApp: App {
    var body: some Scene {
        WindowGroup {
            Content()
                .modelContainer(for: Person.self)
        }
    }
}
