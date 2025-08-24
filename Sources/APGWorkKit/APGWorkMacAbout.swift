//
//  APGWorkMacAbout.swift.swift
//  APGWorkKit
//
//  Created by Steve Sheets on 2025-08-17
//  Based on previous APGWork
//
//  Custom iWork-style About box
//

import APGCantripKit

#if os(macOS)
import Cocoa
import SwiftUI

// MARK: - Class

/// Static manager for the About window..
@MainActor
public final class APGWorkMacAbout {

    // MARK: - Static Function

    /// Show the About window using filled values.
    public static func show() {
        APGWindowTool.makeWindow(
            title: APGWorkShared.aboutAppName,
            ident: APGWorkShared.identifierAboutWindow,
            size: CGSize(width: 560, height: 320)
        ) {
            APGWorkMacAboutView()
        }
    }
}

// MARK: - SwiftUI View

/// About window content view that reads data from APGWorkMacAbout shared
private struct APGWorkMacAboutView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                VStack {
                    Spacer()
                    Image(nsImage: NSApp.applicationIconImage)
                        .resizable()
                        .frame(width: 190, height: 190)
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                        .shadow(radius: 8)
                        .padding([.top, .leading, .trailing], 24)
                    Spacer()
                }
                .frame(width: 238)

                VStack(alignment: .leading, spacing: 0) {
                    GeometryReader { geo in
                        VStack(alignment: .leading, spacing: 0) {
                            VStack(alignment: .leading, spacing: 6) {
                                if !APGWorkGlobals.shared.aboutSymbolName.isEmpty {
                                    if let nsImage = NSImage(systemSymbolName: APGWorkGlobals.shared.aboutSymbolName, accessibilityDescription: String()) {
                                        Image(nsImage: nsImage)
                                            .renderingMode(.original)
                                            .interpolation(.high)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 30)
                                    }
                                }

                                let appName = APGCantrip.appName()
                                if !appName.isEmpty {
                                    Text(appName)
                                        .font(.system(size: 22))
                                        .bold()
                                        .padding(.top, APGWorkGlobals.shared.aboutSymbolName.isEmpty ? 0 : 8)
                                }

                                Text(APGCantrip.appVersionString())
                                    .font(.subheadline)
                                    .padding(.bottom, 8)
                            }

                            Spacer()

                            let text = APGCantrip.copyrightString()
                            if !text.isEmpty {
                                Text(text)
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                                    .padding(.bottom, 4)
                            }
                        }
                        .frame(height: geo.size.height, alignment: .top)
                    }
                }
                .padding([.top, .trailing, .bottom], 24)
            }
            .background(Color.white)

            HStack {
                Spacer()
                if !APGWorkGlobals.shared.aboutAcknowledgmentsLink.isEmpty {
                    Button(APGWorkShared.acknowledgments) {
                        APGCantrip.openRef(APGWorkGlobals.shared.aboutAcknowledgmentsLink)
                    }
                }
                if !APGWorkGlobals.shared.aboutLicensesLink.isEmpty {
                    Button(APGWorkShared.licenses) {
                        APGCantrip.openRef(APGWorkGlobals.shared.aboutLicensesLink)
                    }
                }
            }
            .padding(.horizontal)
            .frame(height: 40)
            .background(Color(NSColor.windowBackgroundColor).opacity(0.9))
        }
        .frame(width: 560, height: 320)
        .background(Color.white)
    }
}

#endif
