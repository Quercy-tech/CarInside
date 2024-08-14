import SwiftUI
import AVFoundation

struct SplashScreenView: View {
    @State private var showObject1 = false
    @State private var showObject2 = false
    @State private var showObject3 = false
    @State private var showObject4 = false
    @State private var showObject5 = false
    @State private var showObject6 = false
    @State private var player: AVAudioPlayer?

    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ZStack {
                if showObject1 {
                    Image("RedCar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .offset(x: showObject6 ? -30 : -150)
                }
                
                if showObject2 {
                    Image("Orange")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .offset(x: showObject6 ? -15 : -75)
                }
                
                if showObject3 {
                    Image("Yellow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .offset(x: showObject6 ? 0 : 0)
                }
                
                if showObject4 {
                    Image("LightBlue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .offset(x: showObject6 ? 15 : 75)
                }
                
                if showObject5 {
                    Image("Blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .offset(x: showObject6 ? 30 : 150)
                }
            }
        }
        .onAppear {
            playEngineSound(sound: "engine_sound", type: "wav")
        }
        .onReceive(timer) { time in
            withAnimation {
                if !showObject1 {
                    showObject1 = true
                } else if !showObject2 {
                    showObject2 = true
                } else if !showObject3 {
                    showObject3 = true
                } else if !showObject4 {
                    showObject4 = true
                } else if !showObject5 {
                    showObject5 = true
                } else if !showObject6 {
                    showObject6 = true
                    timer.upstream.connect().cancel() // Stop the timer once all objects are shown
                }
            }
        }
    }

    func playEngineSound(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            let url = URL(fileURLWithPath: path)
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.volume = 0.5
                // Get the current time and add the offset of 0.5 seconds
                let delay = 0.5
                let startTime = player?.deviceCurrentTime ?? 0 + delay
                player?.play(atTime: startTime)
            } catch {
                print("Error playing sound")
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
