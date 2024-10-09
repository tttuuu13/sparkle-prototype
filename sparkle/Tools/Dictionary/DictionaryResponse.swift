import Foundation

struct Word: Hashable, Codable {    
    let word: String
    let translation: String?
    let phonetic: Phonetic
    var stats: WordStats = WordStats()
}

struct WordStats: Codable, Hashable {
    var rightSwipes: Int = 0
    var rightSwipesInRow: Int = 0
    var leftSwipes: Int = 0
    var dateOfLastRightSwipe: Date? = nil
}

struct WordData: Codable {
    let word: String
    let phonetics: [Phonetic]
    let meanings: [Meaning]
}

struct Phonetic: Codable, Hashable {
    let text: String?
    let audio: String?
}

struct Meaning: Codable {
    let partOfSpeech: String
    let definitions: [Definition]
    let synonyms: [String]
    let antonyms: [String]
}

struct Definition: Codable, Identifiable, Hashable {
    let id: Int?
    let definition: String
    let synonyms: [String]
    let antonyms: [String]
    let example: String?
}

struct TranslationResponse: Codable {
    let data: TranslationsData
}

struct TranslationsData: Codable {
    let translations: [Translation]
}

struct Translation: Codable {
    let translatedText: String
    let model: String
}
