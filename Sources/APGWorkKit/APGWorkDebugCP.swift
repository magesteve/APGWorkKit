//
//  APGWorkDebugCP.swift
//  APGWorkKit
//
//  Created by Steve Sheets on 8/29/25.
//
//  Debug Window Control Panel
//

// MARK: - Imports

import Foundation
import SwiftUI
import APGIntentKit

// MARK: Globals

@MainActor
public var gAPGDebugLevel: Int = 0

// MARK: - Class

/// Text Style Control Panel
@MainActor
public class APGWorkDebugCP: APGWorkControlPanel {
    
    public static let debugToken = APGIntent.debug
    
    public static func register() {
        let cp = APGWorkDebugCP(token: APGWorkDebugCP.debugToken)
        cp.registerControlPanel(name: APGWorkShared.debugSettings, shortName: APGWorkShared.debug, symbolName: APGWorkShared.sfDebugToken)
    }
    
    @ViewBuilder
    override public func makeControlPanelView() -> any View {
        DebugEditorView()
    }
    
    private struct DebugEditorView: View {
        @State private var level: Int = gAPGDebugLevel
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text(APGWorkShared.debug + APGWorkShared.space + APGWorkShared.level)
                    .font(.headline)
                
                Picker(String(), selection: $level) {
                    ForEach(0...5, id: \.self) { level in
                        let title = APGWorkShared.level + APGWorkShared.space + String(level)
                        Text(title).tag(level)
                    }
                }
                .pickerStyle(PopUpButtonPickerStyle())
                .frame(width: 160)
                
                Spacer()
            }
            .padding()
            .onChange(of: level) { _, newValue in
                gAPGDebugLevel = newValue
            }
            .onAppear {
                level = gAPGDebugLevel
            }
        }
    }
}
