import SwiftUI

@main
struct app: App {
    @StateObject private var store = WordsStore()
    var body: some Scene {
        WindowGroup {
            MainView(words: $store.words) {
                Task {
                    do {
                        try await store.save(words: store.words)
                    } catch {
                        fatalError()
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    fatalError()
                }
            }
        }
    }
}
