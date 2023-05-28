//
//  TTSManager.swift
//  SaveUs
//
//  Created by Ruyha on 2023/05/28.
//

//import AVFoundation
//
//class TTSManager {
//
//    static let shared = TTSManager()
//
//    private let synthesizer = AVSpeechSynthesizer()
//
//    internal func play(_ string: String) {
//        let utterance = AVSpeechUtterance(string: string)
//        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
//        utterance.rate = 0.4
//        synthesizer.stopSpeaking(at: .immediate)
//        synthesizer.speak(utterance)
//    }
//
//    internal func stop() {
//        synthesizer.stopSpeaking(at: .immediate)
//    }
//}
import AVFoundation

class TTSManager: NSObject, AVSpeechSynthesizerDelegate {
    
    static let shared = TTSManager()
    
    
    
    private let synthesizer = AVSpeechSynthesizer()
    var completion: (() -> ())?

    override init() {
        super.init()
        synthesizer.delegate = self
    }
    
    internal func play(_ string: String) {
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        utterance.rate = 0.4
        synthesizer.stopSpeaking(at: .immediate)
        synthesizer.speak(utterance)
    }
    
    internal func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        // 소리 재생이 완료되었을 때 실행될 코드를 작성합니다.
        print("소리 재생이 완료되었습니다.")
        self.completion?()
    }
}

