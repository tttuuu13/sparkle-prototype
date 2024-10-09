import SwiftUI

struct AddWordView: View {
    @Binding var words: [Word]
    @Binding var path: [String]
    @StateObject private var viewModel = AddWordViewModel()
    @StateObject private var cardViewModel = CardViewModel()
    @StateObject private var wordInfoViewModel = WordInfoViewModel()
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                
                CardView(cardViewModel: cardViewModel) {
                    TextField("слово", text: $viewModel.input).keyboardType(.alphabet)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 35))
                        .onSubmit {
                            if (viewModel.input != "") {
                                Task {
                                    do {
                                        try await viewModel.word = viewModel.dict.getWord(word: viewModel.input.trimmingCharacters(in: .whitespacesAndNewlines))
                                        wordInfoViewModel.translation = viewModel.word!.translation!
                                        cardViewModel.flipCard()
                                        viewModel.showResetButton = true
                                    } catch {
                                        viewModel.word = Word(word: viewModel.input.trimmingCharacters(in: .whitespacesAndNewlines), translation: nil, phonetic: Phonetic(text: nil, audio: nil))
                                        viewModel.showNotFoundMessage = true
                                        viewModel.showResetButton = true
                                        cardViewModel.flipCard()
                                    }
                                }
                            }
                        }
                } backView: {
                    WordInfoView(wordInfoViewModel: wordInfoViewModel, word: $viewModel.word)
                }.onTapGesture {
                    if viewModel.flipOnTap {
                        cardViewModel.flipCard()
                    }
                }
                
                Label(
                    title: { Text("слово не найдено") },
                    icon: { Image(systemName: "exclamationmark.triangle.fill").foregroundStyle(Color.yellow) }
                )
                .padding(.top, 15)
                .opacity(viewModel.showNotFoundMessage ? 1 : 0)
                .animation(.linear)
                
                Spacer()
                
                Button(action: {
                    words.append(Word(word: viewModel.word!.word, translation: wordInfoViewModel.translation, phonetic: viewModel.word!.phonetic))
                    cardViewModel.flipCard()
                    viewModel.input = ""
                    viewModel.word = nil
                    wordInfoViewModel.translation = ""
                    viewModel.showResetButton = false
                    viewModel.showNotFoundMessage = false
                }, label: {
                    Label(
                        title: { Text("запомнить") },
                        icon: { Image(systemName: "sparkle") }
                    )
                    .padding([.leading, .trailing], 10)
                    .padding([.top, .bottom], 10)
                })
                .background(wordInfoViewModel.translation != "" ? Color(red: 52 / 255, green: 199 / 255, blue: 89 / 255) : Color.gray.opacity(0.2))
                .foregroundStyle(wordInfoViewModel.translation != "" ? Color.white : Color.black.opacity(0.2))
                .buttonStyle(.bordered).clipShape(RoundedRectangle(cornerRadius: 12))
                .disabled(wordInfoViewModel.translation == "")
                .animation(.linear)
                
                Button(action: {
                    cardViewModel.flipCard()
                    viewModel.input = ""
                    viewModel.word = nil
                    wordInfoViewModel.translation = ""
                    viewModel.showResetButton = false
                    viewModel.showNotFoundMessage = false
                }, label: {
                    Text("сбросить")
                })
                .disabled(!viewModel.showResetButton)
                .padding(.top, 10)
                .padding(.bottom, 25)
                .foregroundStyle(Color.red)
                .opacity(viewModel.showResetButton ? 1 : 0)
                .animation(.linear)
            }
            .ignoresSafeArea(.keyboard)
        }
    }
}
