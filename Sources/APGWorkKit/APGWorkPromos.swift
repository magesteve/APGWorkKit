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
    
    // MARK: - Static
    
    public static var promoWidth = 1024
    public static var promoHeight = 700

    // MARK: - Init

    private init() {}

    // MARK: - Show Window

    /// Show the Promos window using filled values.
    public static func show() {
        let name = APGIntentInfoList.shared.find(token: APGIntent.promos)?.name ?? APGWorkShared.otherApps
        
        if let list = APGWorkAppSpecs.shared.promoTileList {

            var listViews: [APGWidgetUIRichTextView] = []
            
            for promo in list {
                let a = promo.makeAttributedString()
                listViews.append(APGWidgetUIRichTextView(attributedText:a))
            }
            
            APGWidgetWindow.makeWindow(
                title: name,
                ident: APGWorkShared.identifierPromosWindow,
                size: CGSize(width: APGWorkPromos.promoWidth, height: APGWorkPromos.promoHeight)
            ) {
                APGWidgetSlideShow(views: listViews)
            }
        }
    }
}

