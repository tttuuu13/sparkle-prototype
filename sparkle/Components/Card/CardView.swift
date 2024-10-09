import SwiftUI

struct CardView<frontContent: View, backContent: View>: View {
    @ObservedObject var cardViewModel: CardViewModel
    @ViewBuilder let frontView: frontContent
    @ViewBuilder let backView: backContent
    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(Color.foreground)
                    .shadow(color: .gray.opacity(0.15), radius: 10)
                frontView
            }
            .frame(width: 300, height: 300)
            .rotation3DEffect(
                Angle(degrees: cardViewModel.frontRotation),
                axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/, perspective: 0.1
            )
            ZStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(Color.foreground)
                    .shadow(color: .gray.opacity(0.15), radius: 10)
                backView
            }
            .frame(width: 300, height: 300)
            .rotation3DEffect(
                Angle(degrees: cardViewModel.backRotation),
                axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/, perspective: 0.1
            )
        }
    }
}
