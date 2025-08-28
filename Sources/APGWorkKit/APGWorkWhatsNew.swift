//
//  APGWorkWhatsNew.swift
//  APGWorkKit
//
//  Created by Steve Sheets on 8/18/25.
//
//  Custom iWork-style What's New box
//

// MARK: Imports

import Foundation
import APGCantripKit
import APGWidgetKit

#if canImport(AppKit) && canImport(SwiftUI)

import AppKit
import SwiftUI

#endif

// MARK: - Class

/// Static manager for the What's New window.
@MainActor
public final class APGWorkWhatsNew {
    
    // MARK: - Static Computed Properties

    /// Can show this window (resources filled)
    public static var canShow: Bool {
        let empty = APGWorkAppHelper.shared.whatsNewFeaturesList.isEmpty
        return !empty
    }

    // MARK: - Static Functions

    /// Show the What's New window using filled values.
    public static func show() {

#if canImport(AppKit) && canImport(SwiftUI)

        APGWidgetWindow.makeWindow(
            title: APGWorkShared.whatsNew,
            ident: APGWorkShared.identifierWhatsNewWindow,
            size: CGSize(width: 900, height: 600)
        ) {
            APGWorkMacWhatsNewView()
        }
        
#endif
        
    }
}

#if canImport(AppKit) && canImport(SwiftUI)

// MARK: - SwiftUI Views

/// What's New window content view that reads data shared
private struct APGWorkMacWhatsNewView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text(APGWorkShared.whatsNewAppName)
                .font(.system(size: 44))
                .padding(.top, 24)

            ScrollView {
                VStack(spacing: 16) {
                    APGWorkMacFeatureList(listFeatureItem: APGWorkAppHelper.shared.whatsNewFeaturesList)

                    if !APGWorkAppHelper.shared.whatsNewFeaturesListLink.isEmpty {
                        if let customColor = APGWorkAppHelper.workUIColor {
                            Text(APGWorkShared.completeFeatureList)
                                .font(.title2)
                                .foregroundColor(customColor)
                                .onTapGesture {
                                    APGCantrip.openRef(APGWorkAppHelper.shared.whatsNewFeaturesListLink)
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.bottom, 8)
                        }
                        else {
                            Text(APGWorkShared.completeFeatureList)
                                .font(.title2)
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    APGCantrip.openRef(APGWorkAppHelper.shared.whatsNewFeaturesListLink)
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.bottom, 8)
                        }
                    }
                }
                .padding(.horizontal)
            }

            HStack {
                Spacer()
                Button {
                    APGWidgetWindow.CloseWindow(ident: APGWorkShared.identifierWhatsNewWindow)
                } label: {
                    Text(APGWorkShared.continueString)
                        .frame(width: 200, height: 30)
                }
                .buttonStyle(.borderedProminent)
                .keyboardShortcut(.defaultAction)
                .tint(APGWorkAppHelper.workUIColor ?? .accentColor)
                
                Spacer()
            }
            .padding()
            .frame(height: 60)
            .background(Color(NSColor.windowBackgroundColor).opacity(0.95))
        }
        .frame(width: 900, height: 600)
        .background(Color.white)
    }
}

#endif
