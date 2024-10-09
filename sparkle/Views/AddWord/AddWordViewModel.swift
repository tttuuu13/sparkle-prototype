import Foundation

final class AddWordViewModel: ObservableObject {
    @Published var input: String = ""
    @Published var word: Word? = nil
    @Published var showResetButton = false
    @Published var showNotFoundMessage = false
    @Published var flipOnTap = false
    let dict = Dictionary()
}
