//
//  PracticeViewModel.swift
//  спаркл
//
//  Created by тимур on 26.07.2024.
//

import Foundation

final class PracticeViewModel: ObservableObject {
    @Published var words: [Word]
    @Published var currentIndex: Int
    @Published var cardOffset: CGSize
    @Published var rightSwipes = 0
    @Published var rightSwipesInRow = 0
    @Published var progress: CGFloat = 0
    
    init(words: [Word], currentIndex: Int = 0, cardOffset: CoreFoundation.CGSize = CGSize.zero) {
        self.words = words.sorted(by: { word1, word2 in
            return word1.stats.rightSwipesInRow > word2.stats.rightSwipesInRow
        })
        self.currentIndex = currentIndex
        self.cardOffset = cardOffset
    }
}
