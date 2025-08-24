//
//  APGWorkMacWhatsNew.swift
//  APGWorkKit
//
//  Created by Steve Sheets on 8/18/25.
//
//  Custom iWork-style What's New box
//

#if os(macOS)
import Cocoa
import SwiftUI

// MARK: - Class

/// Static manager for the What's New window.
@MainActor
public final class APGWorkMacWhatsNew {
    
    // MARK: - Static Computed Properties

    /// Can show this window (resources filled)
    public static var canShow: Bool {
        !APGWorkShared.featuresList.isEmpty
    }

    // MARK: - Static Functions

    /// Show the What's New window using filled values.
    public static func show() {
        APGWindowTool.makeWindow(
            title: String(),
            ident: APGWorkShared.identifierWhatsNewWindow,
            size: CGSize(width: 900, height: 600)
        ) {
            APGWorkMacWhatsNewView()
        }
    }
}

// MARK: - SwiftUI Views

/// A scrollable list of feature items with symbol, title, and description.
public struct APGWorkMacFeatureList: View {
    public let listFeatureItem: [APGWorkFeaturesItem]

    public init(listFeatureItem: [APGWorkFeaturesItem]) {
        self.listFeatureItem = listFeatureItem
    }

    public var body: some View {
        LazyVStack(alignment: .leading, spacing: 28) {
            ForEach(Array(listFeatureItem.enumerated()), id: \.offset) { _, item in
                HStack(alignment: .top, spacing: 20) {
                    if !item.symbolName.isEmpty {
                        if let customColor = APGWorkShared.workUIColor {
                            Image(systemName: item.symbolName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 45, height: 45)
                                .symbolRenderingMode(.monochrome)
                                .foregroundStyle(customColor)
                        } else {
                            Image(systemName: item.symbolName)
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 45, height: 45)
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text(item.title)
                            .font(.title2).bold()
                        Text(item.description)
                            .font(.system(size: 18))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 160)
            }
        }
        .padding(.top, 32)
    }
}

/// What's New window content view that reads data shared
private struct APGWorkMacWhatsNewView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text(APGWorkShared.whatsNewAppName)
                .font(.system(size: 44))
                .padding(.top, 24)

            ScrollView {
                VStack(spacing: 16) {
                    APGWorkMacFeatureList(listFeatureItem: APGWorkShared.featuresList)

                    if !APGWorkShared.featuresListLink.isEmpty {
                        if let customColor = APGWorkShared.workUIColor {
                            Text(APGWorkShared.completeFeatureList)
                                .font(.title2)
                                .foregroundColor(customColor)
                                .onTapGesture {
                                    APGWorkMacApp.openRef(APGWorkShared.featuresListLink)
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.bottom, 8)
                        }
                        else {
                            Text(APGWorkShared.completeFeatureList)
                                .font(.title2)
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    APGWorkMacApp.openRef(APGWorkShared.featuresListLink)
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
                    APGWindowTool.CloseWindow(ident: APGWorkShared.identifierWhatsNewWindow)
                } label: {
                    Text(APGWorkShared.continueString)
                        .frame(width: 200, height: 30)
                }
                .buttonStyle(.borderedProminent)
                .keyboardShortcut(.defaultAction)
                .tint(APGWorkShared.workUIColor ?? .accentColor)
                Spacer()    // <— add this
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
