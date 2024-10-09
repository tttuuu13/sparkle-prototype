//
//  ProgressBar.swift
//  спаркл
//
//  Created by тимур on 02.08.2024.
//

import SwiftUI

struct ProgressBarView: View {
    @Binding var progress: CGFloat
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.gray.opacity(0.3))
            RoundedRectangle(cornerRadius: 5)
                .fill(.green)
                .frame(width: 330 * progress)
        }
        .frame(width: 330, height: 10)
    }
}
