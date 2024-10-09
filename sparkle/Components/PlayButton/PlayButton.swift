import SwiftUI
import AVFoundation

struct PlayButton: View {
    var url: String
    @StateObject private var soundManager = SoundManager()
    
    var body: some View {
        Button(action: {
            soundManager.playSound(url: url)
            soundManager.player?.play()
        }, label: {
            Image(systemName: "speaker.wave.2.circle.fill")
                .font(.system(size: 35))
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        })
    }
}
