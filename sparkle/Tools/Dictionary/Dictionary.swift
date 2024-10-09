import Foundation

class Dictionary {
    func getWord(word: String) async throws -> Word {
        var wordData: WordData
        var wordTranslation: String?
        do {
            wordData = try await getWordData(word: word)
        } catch {
            wordData = WordData(word: word, phonetics: [], meanings: [])
        }
        wordTranslation = try await getTranslation(word: word)
        wordTranslation = wordTranslation?.lowercased()
        return makeValidWord(data: wordData, translation: wordTranslation)
    }
    
    func getWordData(word: String) async throws -> WordData {
        guard let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)") else { throw DictError.InvalidURLError }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let data = try? JSONDecoder().decode([WordData].self, from: data) {
                return data[0]
            } else {
                throw DictError.InvalidDataError
            }
        } catch {
            throw DictError.InvalidDataError
        }
    }
    
    func getTranslation(word: String) async throws -> String {
        guard let url = URL(string: "https://translation.googleapis.com/language/translate/v2?q=\(word)&target=ru&source=en&key=AIzaSyAjWZxqnIHmZ5iBngkqOZeKBvtV2uiMWlE&model=base") else { throw DictError.InvalidURLError }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let (data, _) = try await URLSession.shared.data(for: request)
        if let response = try? JSONDecoder().decode(TranslationResponse.self, from: data) {
            return response.data.translations.first!.translatedText
        } else {
            throw DictError.InvalidDataError
        }
    }
    
    func makeValidWord(data: WordData, translation: String?) -> Word {
        var phoneticText: String? = nil
        var phoneticAudio: String? = nil
        for phonetic in data.phonetics {
            if (phonetic.audio != "" && phonetic.audio != nil && phonetic.text != "" && phonetic.text != nil) {
                phoneticAudio = phonetic.audio
                phoneticText = phonetic.text
                break
            } else if (phonetic.audio != "") {
                phoneticAudio = phonetic.audio
            } else if (phonetic.text != "") {
                phoneticText = phonetic.text
            }
        }
        return Word(word: data.word, translation: translation, phonetic: Phonetic(text: phoneticText, audio: phoneticAudio))
    }

}

enum DictError: Error {
    case InvalidURLError
    case InvalidDataError
}
