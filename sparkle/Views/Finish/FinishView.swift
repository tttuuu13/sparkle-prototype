//
//  FinishView.swift
//  спаркл
//
//  Created by тимур on 11.08.2024.
//

import SwiftUI

struct FinishView: View {
    var rightSwipes: Int
    var wordsPracticed: Int
    var wordsTotal: Int
    @State var viewProgress: CGFloat = 0
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                
                ZStack(alignment: .bottom) {
                    Rectangle()
                        .fill(
                            LinearGradient(stops: [
                                Gradient.Stop(color: .gray.opacity(0.3), location: 0.9 - viewProgress),
                                Gradient.Stop(color: .green, location: 1.1 - viewProgress),
                            ], startPoint: .top, endPoint: .bottom)
                        )
                        .frame(width: 250, height: 250)
                }
                .mask(Image(systemName: "sparkle").font(.system(size: 250)))
                .onAppear {
                    withAnimation(.easeInOut(duration: 3)) {
                        viewProgress = CGFloat(wordsPracticed) / CGFloat(wordsTotal)
                    }
                }
                
                Text("\(wordsPracticed) из \(wordsTotal)")
                    .font(.system(size: 35))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(Color.black.opacity(0.7))
                Text("слов повторено")
                    .font(.system(size: 20))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(Color.black.opacity(0.7))
                
                Spacer()
                
                Button {
                    // end action
                } label: {
                    Text("супер")
                        .padding(10)
                        .foregroundStyle(Color.foreground)
                }
                .background(Color.green)
                .buttonStyle(.bordered)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

#Preview {
    FinishView(rightSwipes: 2, wordsPracticed: 50, wordsTotal: 100)
}
