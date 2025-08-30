//
//  APGWorkSoundCP.swift
//  APGWorkKit
//
//  Created by Steve Sheets on 8/29/25.
//

// MARK: Imports

import Foundation
import SwiftUI
import APGIntentKit

// MARK: Class

/// Sound Control Panel
@MainActor
open class APGWorkSoundCP: APGWorkControlPanel {
    
    @ObservedObject var soundManager = APGWorkSoundManager.shared

    public static let soundToken = "APGWork-Sound"
    
    public static func register() {
        let cp = APGWorkSoundCP(token: APGWorkSoundCP.soundToken)
        cp.registerControlPanel(name: "Sound Settings", shortName: "Sound", symbolName: "sun.max")
    }
    
    @ViewBuilder
    override public func makeControlPanelView() -> any View {
        VStack(alignment: .leading) {
            Text("Sound Settings")
                .font(.title2)
                .padding(.bottom, 8)

            Form {
                Toggle("Mute All Sounds", isOn: $soundManager.isMuted)

                HStack {
                    Text("Sound Level")

                    Slider(value: Binding(
                        get: { Double(self.soundManager.soundLevel) },
                        set: { self.soundManager.setSoundLevel(Int($0)) }
                    ), in: 1...10, step: 1)

                    Text("\(soundManager.soundLevel)")
                        .frame(width: 30, alignment: .trailing)
                }

                Button("Play System Sound (Ping)") {
                    APGWorkSoundManager.playSystem(name: "Ping")
                }
                .disabled(soundManager.isMuted)
            }

            Spacer()
        }
        .padding()
        .frame(minWidth: 300, minHeight: 160)
    }

}

