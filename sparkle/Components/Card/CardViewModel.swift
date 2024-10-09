import SwiftUI
import Foundation

final class CardViewModel: ObservableObject {
    var duration: CGFloat = 0.2
    @Published var offset = CGSize.zero
    @Published var frontRotation: Double = 0
    @Published var backRotation: Double = -90
    @Published var isFlipped: Bool = false
    
    func flipCard () {
        isFlipped.toggle()
        if isFlipped {
            withAnimation(.easeIn(duration: duration)) {
                frontRotation = 90
            }
            withAnimation(.easeOut(duration: duration).delay(duration)) {
                backRotation = 0
            }
        } else {
            withAnimation(.easeIn(duration: duration)) {
                backRotation = -90
            }
            withAnimation(.easeOut(duration: duration).delay(duration)) {
                frontRotation = 0
            }
        }
    }
}
