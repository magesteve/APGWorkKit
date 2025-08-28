//
//  APGWorkWelcome.swift
//  MacDocSpike
//
//  Created by Steve Sheets on 8/19/25.
//
//  Custom iWork-style Welcome box
//

// MARK: Imports

import Foundation
import APGCantripKit
import APGWidgetKit
import APGIntentKit

#if canImport(AppKit) && canImport(SwiftUI)

import AppKit
import SwiftUI

#endif

// MARK: - Class

import AppKit
import APGWidgetKit
import SwiftUI

// MARK: - Class

/// Static manager for the Welcome window..
@MainActor
public final class APGWorkWelcome {

    // MARK: - Stored Data


    // MARK: - Init

    private init() {}

    // MARK: - Show Window

    public static func show() {
        APGWidgetWindow.makeWindow(
            title: APGWorkShared.welcome,
            ident: APGWorkShared.identifierWelcomeWindow,
            size: CGSize(width: 900, height: 600)
        ) {
            APGWorkMacWelcomeView(
                subTitle: APGWorkAppHelper.shared.welcomeSubTitle,
                agreementRef: APGWorkAppHelper.shared.welcomeAgreementRef,
                imageNames: APGWorkAppHelper.shared.welcomeImageNames,
            )
        }
    }
}

// MARK: - SwiftUI View

private struct APGWorkMacWelcomeView: View {
    let subTitle: String
    let agreementRef: String?
    let imageNames: [String]

    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 40)

            Text(APGWorkShared.welcomeToAppName)
                .font(.system(size: 36))
                .padding(.bottom, 8)

            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 1)
                .padding(.horizontal, 100)

            if !subTitle.isEmpty {
                Text(subTitle)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.top, 12)
                    .padding(.horizontal, 60)
            }

            Spacer()

            APGWidgetStackedImageView(imageNames: Array(imageNames.prefix(5)))

            Spacer()

            HStack {
                Spacer()
                APGWidgetLargeButton(title: APGWorkShared.continueString, isDefault: true) {
                    APGWidgetWindow.CloseWindow(ident: APGWorkShared.identifierWelcomeWindow)
                    APGWorkGetStarted.show()
                }
                Spacer()
            }
            .padding(.vertical)
            .frame(height: 60)
            .background(Color(NSColor.windowBackgroundColor).opacity(0.9))
        }
        .frame(width: 900, height: 600)
        .background(Color.white)
    }


}
