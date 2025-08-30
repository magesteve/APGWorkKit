//
//  APGWorkGetStarted.swift
//  APGWorkKit
//
//  Created by Steve Sheets on 8/27/25.
//

// MARK: Imports

import Foundation
import APGCantripKit
import APGWidgetKit
import SwiftUI

// MARK: - Class

/// Static manager for the Get Started window..
@MainActor
public final class APGWorkGetStarted {

    // MARK: - Show Window

    /// Show the Get Started window using filled values.
    public static func show() {
        APGWidgetWindow.makeWindow(
            title: APGWorkShared.getStarted,
            ident: APGWorkShared.identifierGetStartedWindow,
            size: CGSize(width: 900, height: 600)
        ) {
            APGWorkMacGetStartedView(
                features: APGWorkAppHelper.shared.getStartedFeaturesList
            )
        }
    }
}

// MARK: - SwiftUI View

private struct APGWorkMacGetStartedView: View {
    let features: [APGWorkFeatureItem]

    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 30)

            Text(APGWorkShared.getStarted)
                .font(.system(size: 36))
                .padding(.bottom, 4)

            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 1)
                .padding(.horizontal, 100)

            ScrollView {
                VStack(spacing: 16) {
                    APGWorkMacFeatureList(listFeatureItem: APGWorkAppHelper.shared.getStartedFeaturesList)

                    if !APGWorkAppHelper.shared.getStartedFeaturesListLink.isEmpty {
                        if let customColor = APGWorkAppHelper.workUIColor {
                            Text(APGWorkShared.completeFeatureList)
                                .font(.title2)
                                .foregroundColor(customColor)
                                .onTapGesture {
                                    APGCantrip.openRef(APGWorkAppHelper.shared.getStartedFeaturesListLink)
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.bottom, 8)
                        }
                        else {
                            Text(APGWorkShared.completeFeatureList)
                                .font(.title2)
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    APGCantrip.openRef(APGWorkAppHelper.shared.getStartedFeaturesListLink)
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.bottom, 8)
                        }
                    }
                }
                .padding(.horizontal)
            }

            HStack(spacing: 40) {
                APGWidgetLargeButton(title: APGWorkShared.openDocuments) {
                    NSDocumentController.shared.openDocument(nil)
                    APGWidgetWindow.CloseWindow(ident: APGWorkShared.identifierGetStartedWindow)
                }

                APGWidgetLargeButton(title:APGWorkShared.newDocument, isDefault: true) {
                    NSDocumentController.shared.newDocument(nil)
                    APGWidgetWindow.CloseWindow(ident: APGWorkShared.identifierGetStartedWindow)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .frame(height: 60)
            .background(Color(NSColor.windowBackgroundColor).opacity(0.9))
        }
        .frame(width: 900, height: 600)
        .background(Color.white)
    }
}
