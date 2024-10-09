//
//  MainView.swift
//  спаркл
//
//  Created by тимур on 25.07.2024.
//

import SwiftUI

struct MainView: View {
    @Binding var words: [Word]
    @State private var path = [String]()
    @Environment(\.scenePhase) var scenePhase
    let saveAction: () -> Void
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 55))
                        .fontWeight(.medium)
                        .foregroundStyle(Color.gray.opacity(0.4))
                        .onTapGesture {
                            path.append("profile")
                        }
                }
                
                Spacer()
                
                HStack {
                    ZStack {
                        Text("статис-\nтика")
                            .font(.system(size: 28))
                            .fontWeight(.medium)
                            .opacity(0.8)
                            .padding(.bottom, 65)
                            .padding(.trailing, 15)
                        Image(systemName: "sparkle")
                            .font(.system(size: 100))
                            .fontWeight(.medium)
                            .padding([.leading, .top], 80)
                            .foregroundStyle(Color.yellow)
                            .opacity(0.8)
                        
                    }
                    .frame(width: 150, height: 150)
                    .background(Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .onTapGesture {
                        path.append("statistics")
                    }
                    
                    Spacer()
                    
                    ZStack {
                        Text("добавить\nслово")
                            .font(.system(size: 28))
                            .fontWeight(.medium)
                            .opacity(0.8)
                            .padding(.bottom, 65)
                        Image(systemName: "globe")
                            .font(.system(size: 100))
                            .fontWeight(.medium)
                            .padding([.leading, .top], 80)
                            .foregroundStyle(Color.blue)
                            .opacity(0.8)
                    }
                    .frame(width: 150, height: 150)
                    .background(Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .onTapGesture {
                        path.append("addWord")
                    }
                }
                .padding(.bottom, 5)
                
                HStack {
                    ZStack {
                        Text("словарь")
                            .font(.system(size: 28))
                            .fontWeight(.medium)
                            .opacity(0.8)
                            .padding(.bottom, 65)
                            .padding(.trailing, 15)
                        Image(systemName: "square.stack.3d.up.fill")
                            .font(.system(size: 100))
                            .fontWeight(.medium)
                            .padding([.leading, .top], 80)
                            .foregroundStyle(Color.purple)
                            .opacity(0.8)
                        
                    }
                    .frame(width: 150, height: 150)
                    .background(Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .onTapGesture {
                        path.append("dictionary")
                    }
                    
                    Spacer()
                    
                    ZStack {
                        Text("повторить\nслова")
                            .font(.system(size: 28))
                            .fontWeight(.medium)
                            .opacity(0.8)
                            .padding(.bottom, 65)
                        Image(systemName: "repeat.circle.fill")
                            .font(.system(size: 100))
                            .fontWeight(.medium)
                            .padding([.leading, .top], 80)
                            .foregroundStyle(Color.green)
                            .opacity(0.8)
                    }
                    .frame(width: 150, height: 150)
                    .background(Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .onTapGesture {
                        path.append("practice")
                    }
                }
                
                Spacer()
            }
            .onChange(of: scenePhase) { phase in
                if (phase == .inactive) {
                    saveAction()
                }
            }
            .padding(40)
            .background(Color.background)
            .navigationDestination(for: String.self) { option in
                switch (option) {
                case "profile": 
                    Text("Profile page")
                case "statistics":
                    Text("Stats page")
                case "addWord":
                    AddWordView(words: $words, path: $path)
                case "practice":
                    PracticeView(viewModel: PracticeViewModel(words: words), path: $path)
                case "dictionary":
                    DictionaryView(words: $words)
                default:
                    Text("default")
                }
            }
        }
    }
}
