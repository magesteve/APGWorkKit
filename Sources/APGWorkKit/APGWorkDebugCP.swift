//
//  APGWorkDebugCP.swift
//  APGWorkKit
//
//  Created by Steve Sheets on 8/29/25.
//

// MARK: - Imports

import Foundation
import SwiftUI

// MARK: Globals

@MainActor
public var gAPGDebugLevel: Int = 0

// MARK: - Class

/// Text Style Control Panel
@MainActor
public class APGWorkDebugCP: APGWorkControlPanel {
    
    public static let debugToken = "APGWork-Debug"
    
    public static func register() {
        let cp = APGWorkDebugCP(token: APGWorkDebugCP.debugToken)
        cp.registerControlPanel(name: "Debug Settings", shortName: "Debug", symbolName: "sun.max")
    }
    
    @ViewBuilder
    override public func makeControlPanelView() -> any View {
        DebugEditorView()
    }
    
    private struct DebugEditorView: View {
        @State private var level: Int = gAPGDebugLevel
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("Debug Level")
                    .font(.headline)
                
                Picker("", selection: $level) {
                    ForEach(0...5, id: \.self) { level in
                        Text("Level \(level)").tag(level)
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
