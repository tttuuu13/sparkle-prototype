//
//  streakFlameView.swift
//  спаркл
//
//  Created by тимур on 31.07.2024.
//

import SwiftUI

struct streakFlameView: View {
    @Binding var counter: Int
    var body: some View {
        ZStack {
            Image("streakFlameBg")
                .resizable()
                .scaledToFit()
            Text("\(counter)")
                .font(.system(size: 30, weight: .black, design: .rounded))
                .padding(.top, 20)
                .foregroundStyle(Color.yellow)
                .shadow(color: Color.yellow, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
        .frame(height: 70)
    }
}
