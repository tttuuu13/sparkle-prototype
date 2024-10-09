import Foundation
import AVFoundation
import AVFAudio

class SoundManager: ObservableObject {
    var player: AVPlayer?
    
    func playSound(url: String) {
        if let url = URL(string: url) {
            self.player = AVPlayer(url: url)
        }
    }
}
