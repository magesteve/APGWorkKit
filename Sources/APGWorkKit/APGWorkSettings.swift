//
//  APGWorkSettings.swift
//  APGWorkKit
//
//  Created by Steve Sheets on 8/29/25.
//

// MARK: Imports

import Foundation
import SwiftUI
import APGCantripKit
import APGWidgetKit
import APGIntentKit

#if canImport(AppKit)

import AppKit

#endif

// MARK: - Shared Model

@MainActor
public final class APGWorkSettingsModel: ObservableObject {
    @Published public var selectedToken: String = String()
    public var didSetInitialToken: Bool = false
}

extension APGWorkSettings {
    public static let model = APGWorkSettingsModel()
}

// MARK: - Class

/// Static manager for the Settings window.
///     Currently only supports AppKit through SwiftUI
@MainActor
public final class APGWorkSettings {

    // MARK: - Static

    public static var listControlPanels: [APGWorkControlPanel] = []

    // MARK: - Static Function

    /// Show the Settings window with control panel selector.
    public static func show(token: String = String()) {
        
#if canImport(AppKit)

        // Determine title from token (or fallback)
        let windowTitle = APGIntentInfoList.shared.find(token: token)?.useShortName ?? APGWorkShared.settings

        APGWidgetWindow.makeWindow(
            title: windowTitle,
            ident: APGWorkShared.identifierSettingsWindow,
            size: CGSize(width: 560, height: 320),
            onReuse: {
                // If token is valid and different, switch panels and rename
                if !token.isEmpty,
                   token != APGWorkSettings.model.selectedToken,
                   APGWorkSettings.listControlPanels.contains(where: { $0.token == token }) {
                    APGWorkSettings.model.selectedToken = token
                    APGWidgetWindow.renameWindow(title: windowTitle, ident: APGWorkShared.identifierSettingsWindow)
                }
            }
        ) {
            APGWorkMacSettingsView(startingToken: token)
        }

#endif
        
    }
}

#if canImport(AppKit)

// MARK: - SwiftUI View

/// AppKit Setting View
private struct APGWorkMacSettingsView: View {
    let startingToken: String
    @ObservedObject private var model = APGWorkSettings.model

    var body: some View {
        VStack(spacing: 0) {

            // Top icon row
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(APGWorkSettings.listControlPanels, id: \.token) { panel in
                        if let info = APGIntentInfoList.shared.find(token: panel.token),
                           let symbol = info.symbolName {
                            APGWidgetIconButton(
                                title: info.useShortName,
                                symbolName: symbol,
                                isSelected: (panel.token == model.selectedToken)
                            ) {
                                model.selectedToken = panel.token
                            }
                        }
                    }
                }
                .padding(.vertical)
                .padding(.horizontal)
            }
            .APGWorkBackgroundBannerColor()

            Divider()

            // Bottom panel view
            Group {
                if let selectedPanel = APGWorkSettings.listControlPanels.first(where: { $0.token == model.selectedToken }) {
                    AnyView(selectedPanel.makeControlPanelView())
                        .padding()
                        .onAppear {
                            APGWidgetWindow.renameWindow(title: selectedPanel.panelName, ident: APGWorkShared.identifierSettingsWindow)
                        }
                } else {
                    Text("No control panel selected.")
                        .foregroundColor(.secondary)
                        .padding()
                        .onAppear {
                            APGWidgetWindow.renameWindow(title: APGWorkShared.settings, ident: APGWorkShared.identifierSettingsWindow)
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(width: 560, height: 320)
        .background(Color.white)
        .onAppear {
            guard !model.didSetInitialToken else { return }
            model.didSetInitialToken = true

            let matched = APGWorkSettings.listControlPanels.contains { $0.token == startingToken }
            model.selectedToken = matched
                ? startingToken
                : APGWorkSettings.listControlPanels.first?.token ?? ""
        }
        .onChange(of: model.selectedToken) { oldValue, newValue in
            let title = APGIntentInfoList.shared.find(token: newValue)?.useShortName ?? APGWorkShared.settings
            APGWidgetWindow.renameWindow(title: title, ident: APGWorkShared.identifierSettingsWindow)
        }
    }
}

#endif

