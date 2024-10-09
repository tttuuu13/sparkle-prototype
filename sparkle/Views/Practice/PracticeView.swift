//
//  PracticeView.swift
//  спаркл
//
//  Created by тимур on 26.07.2024.
//

import SwiftUI

struct PracticeView: View {
    @StateObject var viewModel: PracticeViewModel
    @Binding var path: [String]
    @StateObject private var cardViewModel = CardViewModel()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .bottom) {
                Color.background.ignoresSafeArea(.all)

                VStack {
                    streakFlameView(counter: $viewModel.rightSwipesInRow)
                    .padding(.bottom, 100)
                    .padding(.leading, 300)
                    
                    if (viewModel.currentIndex < viewModel.words.count) {
                        ZStack {
                            if (viewModel.currentIndex + 1 < viewModel.words.count){
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .fill(Color.foreground)
                                        .frame(width: 300, height: 300)
                                        .shadow(color: .gray.opacity(0.15), radius: 10)
                                    Text(viewModel.words[viewModel.currentIndex + 1].word)
                                        .font(.system(size: 35))
                                }
                                .opacity(abs(viewModel.cardOffset.width / 60.0))
                            }
                            
                            ZStack {
                                CardView(cardViewModel: cardViewModel, frontView: {
                                    Text(viewModel.words[viewModel.currentIndex].word)
                                        .font(.system(size: 35))
                                }, backView: {
                                    VStack {
                                        Text(viewModel.words[viewModel.currentIndex].translation!)
                                            .font(.system(size: 40))
                                            .multilineTextAlignment(.center)
                                        if (viewModel.words[viewModel.currentIndex].phonetic.text != nil) {
                                            Text(viewModel.words[viewModel.currentIndex].phonetic.text!)
                                                .font(.system(size: 25)).opacity(0.6)
                                        }
                                    }
                                    if (viewModel.words[viewModel.currentIndex].phonetic.audio != nil) {
                                        PlayButton(url: viewModel.words[viewModel.currentIndex].phonetic.audio!)
                                            .padding(.leading, 235)
                                            .padding(.top, 235)
                                    }
                                })
                            }
                            .rotationEffect(.degrees(viewModel.cardOffset.width / 5.0))
                            .offset(x: viewModel.cardOffset.width * 3, y: viewModel.cardOffset.height / 3)
                            .opacity(Double(2) - abs(viewModel.cardOffset.width / 60.0))
                            .onTapGesture {
                                cardViewModel.flipCard()
                            }
                            .gesture(
                                DragGesture()
                                    .onChanged({ gesture in
                                        viewModel.cardOffset = gesture.translation
                                    })
                                    .onEnded({ gesture in
                                        if (abs(viewModel.cardOffset.width) > 60) {
                                            if (viewModel.currentIndex >= viewModel.words.count) {
                                                path.append("finish")
                                            }
                                            if (viewModel.cardOffset.width > 60) {
                                                viewModel.words[viewModel.currentIndex].stats.rightSwipes += 1
                                                viewModel.words[viewModel.currentIndex].stats.rightSwipesInRow += 1
                                                withAnimation {
                                                    viewModel.rightSwipesInRow += 1
                                                }
                                                viewModel.rightSwipes += 1
                                            } else {
                                                viewModel.words[viewModel.currentIndex].stats.leftSwipes += 1
                                                viewModel.words[viewModel.currentIndex].stats.rightSwipesInRow = 0
                                                viewModel.rightSwipesInRow = 0
                                            }
                                            if cardViewModel.isFlipped {
                                                cardViewModel.isFlipped.toggle()
                                                cardViewModel.frontRotation = 0
                                                cardViewModel.backRotation = -90
                                            }
                                            viewModel.currentIndex += 1
                                            withAnimation(.bouncy) {
                                                viewModel.progress = CGFloat(viewModel.currentIndex) / CGFloat(viewModel.words.count)
                                            }
                                            viewModel.cardOffset = .zero
                                        } else {
                                            withAnimation(.bouncy(duration: 0.3)) {
                                                viewModel.cardOffset = .zero
                                            }
                                        }
                                    })
                            )
                        }
                    } else {
                        EmptyView()
                    }
                    
                    Spacer()
                }
                
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.foreground)
                        .ignoresSafeArea()
                        .shadow(color: .gray.opacity(0.1), radius: 10)
                    
                    VStack {
                        ProgressBarView(progress: $viewModel.progress)
                            .padding(.top, 25)
                            .padding(.bottom, 10)
                            
                        HStack {
                            Spacer()
                            Button {
                                path.append("finish")
                            } label: {
                                Text("завершить")
                                    .padding(10)
                                    .foregroundStyle(Color.foreground)
                            }
                            .background(Color.green)
                            .buttonStyle(.bordered)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.trailing, 35)
                            
                            Button {
                                viewModel.currentIndex += 1
                                viewModel.words.remove(at: viewModel.currentIndex)
                                withAnimation(.bouncy) {
                                    viewModel.progress = CGFloat(viewModel.currentIndex) / CGFloat(viewModel.words.count)
                                }
                            } label: {
                                Image(systemName: "trash.fill")
                                    .padding(20)
                                    .foregroundStyle(Color.red.opacity(0.8))
                            }
                            .disabled(viewModel.currentIndex >= viewModel.words.count)
                            .background(Color.foreground)
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                            .padding(.trailing, 30)
                            .shadow(color: .gray.opacity(0.2), radius: 20)
                        }
                    }
                }
                .frame(height: 150)
            }
        }
        .navigationDestination(for: String.self) { option in
            if (option == "finish") {
                FinishView(rightSwipes: viewModel.rightSwipes, wordsPracticed: viewModel.currentIndex, wordsTotal: viewModel.words.count)
            }
        }
    }
}

