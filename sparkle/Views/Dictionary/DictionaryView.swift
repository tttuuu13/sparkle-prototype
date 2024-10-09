//
//  Dictionary.swift
//  спаркл
//
//  Created by тимур on 26.07.2024.
//

import SwiftUI

struct DictionaryView: View {
    @Binding var words: [Word]
    var body: some View {
        VStack {
            List {
                ForEach(words, id: \.word) { word in
                    Text(word.word)
                        .swipeActions {
                            Button(action: {
                                words.remove(at: words.firstIndex(of: word)!)
                            }, label: {
                                Image(systemName: "trash.circle.fill")
                            })
                            .tint(Color.red)
                        }
                }
            }
        }
    }
}
