//
//  APGWorkSoundManager.swift
//  APGWorkKit
//
//  Created by Steve Sheets on 8/29/25.
//

import Foundation
import AVFoundation
import SwiftUI
import Combine

import AppKit

@MainActor
public final class APGWorkSoundManager: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    // MARK: - Shared Instance

    public static let shared = APGWorkSoundManager()

    // MARK: - Published Properties

    @Published public var isMuted: Bool = false {
        didSet { saveSettings() }
    }

    @Published public var soundLevel: Int = 5 {
        didSet {
            soundLevel = max(1, min(soundLevel, 10))
            saveSettings()
        }
    }

    @Published public private(set) var isSpeaking: Bool = false

    // MARK: - Internal

    private var synthesizer = AVSpeechSynthesizer()
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Init

    private override init() {
        super.init()
        loadSettings()
        synthesizer.delegate = self
    }

    // MARK: - Static Sound API

    public static func play(name: String) {
        shared.playSound(named: name)
    }

    public static func playSystem(name: String) {
        shared.playSystemSound(named: name)
    }

    public static func say(_ text: String) {
        shared.speakText(text)
    }

    // MARK: - Public Methods

    public var isEnabled: Bool {
        !isMuted && soundLevel > 0
    }

    public func speakText(_ text: String) {
        stopSpeaking()
        guard isEnabled else { return }

        let utterance = AVSpeechUtterance(string: text)
        utterance.volume = Float(soundLevel) / 10.0
        isSpeaking = true
        synthesizer.speak(utterance)
    }

    public func stopSpeaking() {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
    }

    // MARK: - Sound (App Embedded)

    private func playSound(named name: String) {
        // Future: bundle-based audio
    }

    private func playSystemSound(named name: String) {
        guard isEnabled else { return }

        NSSound(named: name)?.volume = Float(soundLevel) / 10.0
        NSSound(named: name)?.play()
    }

    // MARK: - Settings

    private func saveSettings() {
        UserDefaults.standard.set(isMuted, forKey: "APGWorkSoundManager.muted")
        UserDefaults.standard.set(soundLevel, forKey: "APGWorkSoundManager.soundLevel")
    }

    private func loadSettings() {
        isMuted = UserDefaults.standard.bool(forKey: "APGWorkSoundManager.muted")
        soundLevel = UserDefaults.standard.integer(forKey: "APGWorkSoundManager.soundLevel")
        if soundLevel == 0 { soundLevel = 5 }
    }
}

// MARK: - AVSpeechSynthesizerDelegate

extension APGWorkSoundManager {
    public nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.isSpeaking = false
        }
    }

    public nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.isSpeaking = false
        }
    }
}
