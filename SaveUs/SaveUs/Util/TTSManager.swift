////
////  TTSManager.swift
////  SaveUs
////
////  Created by Ruyha on 2023/05/28.
////
//
//import AVFoundation
//import UIKit
//
//class TTSManager {
//    static let shared = TTSManager()
//
//    private let audioSession = AVAudioSession.sharedInstance()
//    private let synthesizer = AVSpeechSynthesizer()
//    var completion: (() -> ())?
//
//    internal func play(_ string: String) {
//        let utterance = AVSpeechUtterance(string: string)
//        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
//        utterance.rate = 0.4
//        utterance.volume = 1.0 // 최대 소리
//
//
//        do {
//            try audioSession.setCategory(.playback)
//            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
//        } catch {
//            print("Failed to set audio session category: \(error)")
//        }
//
//        synthesizer.stopSpeaking(at: .immediate)
//        synthesizer.speak(utterance)
//    }
//
//    internal func stop() {
//        synthesizer.stopSpeaking(at: .immediate)
//
//        do {
//            try audioSession.setActive(false, options: .notifyOthersOnDeactivation)
//        } catch {
//            print("Failed to deactivate audio session: \(error)")
//        }
//    }
////
//
//}
//
//
