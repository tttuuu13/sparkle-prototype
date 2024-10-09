//
//  WordCardView.swift
//  cards
//
//  Created by тимур on 23.07.2024.
//

import SwiftUI

struct WordInfoView: View {
    @ObservedObject var wordInfoViewModel: WordInfoViewModel
    @Binding var word: Word?
    
    var body: some View {
        ZStack {
            if (word != nil) {
                VStack {
                    TextField("перевод", text: $wordInfoViewModel.translation)
                        .font(.system(size: 40))
                        .multilineTextAlignment(.center)
                    if (word!.phonetic.text != nil) {
                        Text(word!.phonetic.text!)
                            .font(.system(size: 25)).opacity(0.6)
                    }
                }
                if (word!.phonetic.audio != nil) {
                    PlayButton(url: word!.phonetic.audio!)
                        .padding(.leading, 235)
                        .padding(.top, 235)
                }
            } else {
                TextField("перевод", text: $wordInfoViewModel.translation)
                    .font(.system(size: 40))
                    .multilineTextAlignment(.center)
            }
        }
        .frame(width: 300, height: 300)
    }
}
