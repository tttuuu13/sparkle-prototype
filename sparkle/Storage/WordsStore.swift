//
//  CardsStore.swift
//  спаркл
//
//  Created by тимур on 25.07.2024.
//

import Foundation
import SwiftUI

@MainActor
class WordsStore: ObservableObject {
    @Published var words: [Word] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("words.data")
    }
    
    func load() async throws {
        let task = Task<[Word], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let decodedData = try JSONDecoder().decode([Word].self, from: data)
            return decodedData
        }
        let words = try await task.value
        self.words = words
    }
    
    func save(words: [Word]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(words)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
