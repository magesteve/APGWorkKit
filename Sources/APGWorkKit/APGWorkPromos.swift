//
//  APGWorkFAQ.swift
//  APGWorkKit
//
//  Created by Steve Sheets on 8/30/25.
//
//  Promotion (other apps) window
//

// MARK: Imports

import Foundation
import APGCantripKit
import APGWidgetKit
import APGIntentKit
import SwiftUI

#if canImport(AppKit)

import AppKit

#endif

// MARK: - Class

/// Static manager for the Promos window..
@MainActor
public final class APGWorkPromos {

    // MARK: - Init

    private init() {}

    // MARK: - Show Window

    /// Show the Promos window using filled values.
    public static func show() {
        let name = APGIntentInfoList.shared.find(token: APGIntent.promos)?.name ?? APGWorkShared.otherApps
        
        APGWidgetWindow.makeWindow(
            title: name,
            ident: APGWorkShared.identifierPromosWindow,
            size: CGSize(width: 500, height: 600)
        ) {
            APGWorkMacPromosView(tiles: APGWorkAppSpecs.shared.promoTileList ?? [])
        }
    }
}

// MARK: - SwiftUI View

private struct APGWorkMacPromosView: View {
    let tiles: [APGWorkPromoTile]

    var body: some View {
        VStack(spacing: 0) {
        }
    }
}
