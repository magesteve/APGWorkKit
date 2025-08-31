//
//  APGWorkAppSpecs.swift
//  APGWorkKit
//
//  Created by Steve Sheets on 8/17/25.
//
//  App level function relating to Work UI
//

// MARK: - Import

import Foundation
import APGIntentKit
import APGCantripKit
import SwiftUI

// MARK: - Struct

/// Specs for the Work app
public struct APGWorkAppSpecs: Decodable {
    
    // MARK: - Static Variables
    ///
    /// Singleton reference
    @MainActor
    public static var shared = APGWorkAppSpecs()
    
    // MARK: - Public Variables
    
    /// Color used in Work UI (optional theme override)
    public var workRGB: APGCantripRGB?
    
    /// About Symbol name to show in About
    public var aboutSymbolName: String?
    
    /// About Acknowledgments external reference (URL string or file path)
    public var aboutAcknowledgmentsLink: String?
    
    /// About Licenses external reference (URL string or file path)
    public var aboutLicensesLink: String?
    
    /// What's New features
    public var whatsNewFeaturesList: [APGWorkFeatureItem]?
    
    /// What's new Optional external 'New Feature List' reference (URL/file)
    public var whatsNewFeaturesListLink: String?
    
    /// Get Started features
    public var getStartedFeaturesList: [APGWorkFeatureItem]?
    
    /// Get Started Optional external 'Complete Feature List' reference (URL/file)
    public var getStartedFeaturesListLink: String?
    
    /// Additional about menu item Token
    public var aboutTokens: [String]?
    
    /// Additional help menu item Token
    public var helpTokens: [String]?
    
    /// Welcome subtitle
    public var welcomeSubTitle: String?
    
    /// Welcome Agreement Reference
    public var welcomeAgreementRef: String?
    
    /// Welcome List of Image names to display
    public var welcomeImageNames: [String]?
    
    /// FAQ Topic/Entries
    public var faqTopics: [APGWorkFAQTopic]?
    
    /// FAQ References
    public var faqReferences: [APGWorkFAQReference]?
    
    /// Promos title
    public var promosTitle: String?
    
    /// Promos Tiles
    public var promoTileList: [APGWorkPromoTile]?
    
    // MARK: - Computed Var
    
    @MainActor
    public var workUIColor: Color? {
        guard let rgb = workRGB else { return nil }
        
        return rgb.swiftUIColor
    }
    
    /// Standard background color for banner areas (e.g., toolbar rows).
    @MainActor
    public static var backgroundBannerColor: Color {
        Color(APGCantripColor.windowBackgroundColor).opacity(0.95)
    }
    
    // MARK: - Public Functions
    
    /// Add additional items to premade intents
    @MainActor
    public mutating func addAdditionalMenuIntents(about: [String]? = nil,
                                         help: [String]? = nil) {
        self.aboutTokens = about
        self.helpTokens = help
    }
    
    // MARK: - Init
    
    /// do nothing init
    public init() {}
    
    // MARK: - Static Function
    
    /// Init App stuff
    @MainActor
    public static func appInit() {
        APGIntentInfoList.shared.add(contentsOf: [
            APGIntentInfo(token: APGIntent.about,
                          name: APGWorkShared.aboutAppName,
                          symbolName: APGWorkShared.sfAboutToken),
            APGIntentInfo(token: APGIntent.whatsnew,
                          name: APGWorkShared.whatsNewAppName,
                          symbolName: APGWorkShared.sfWhatsNewToken),
            
            APGIntentInfo(token: APGIntent.welcome,
                          name: APGWorkShared.welcome,
                          symbolName: APGWorkShared.sfWelcomeToken),
            APGIntentInfo(token: APGIntent.faq,
                          name: APGWorkShared.faq,
                          symbolName: APGWorkShared.sfFAQToken),
            APGIntentInfo(token: APGIntent.getStarted,
                          name: APGWorkShared.getStarted,
                          symbolName: APGWorkShared.sfGetStartedToken),
            APGIntentInfo(token: APGIntent.settings,
                          name: APGWorkShared.settings,
                          symbolName: APGWorkShared.sfSettingsToken),
            APGIntentInfo(token: APGIntent.promos,
                          name: APGWorkShared.otherApps,
                          symbolName: APGWorkShared.sfPromosToken)
        ])
    }
    
    /// Setup App stuff
    @MainActor
    public static func appPrepare() {
        var someAbout = [APGIntent.about]
        if let _ = APGWorkAppSpecs.shared.promoTileList {
            someAbout.append(contentsOf: [APGIntent.promos])
        }
        if let addList = APGWorkAppSpecs.shared.aboutTokens {
            someAbout.append(contentsOf: addList)
        }
        if let promoTitle = APGWorkAppSpecs.shared.promosTitle {
            let info = APGIntentInfo(token: APGIntent.promos,
                          name: promoTitle,
                          symbolName: APGWorkShared.sfPromosToken)
            APGIntentInfoList.shared.replace(info)
        }
        
        var someSettings: [String]?
        if !APGWorkSettings.listControlPanels.isEmpty {
            someSettings = [APGIntent.settings]
        }
        
        APGIntentMacTools.addAppMenuIntents(about: someAbout, settings: someSettings)

        var someHelp: [String] = [String(), APGIntent.whatsnew]
        if let addList = APGWorkAppSpecs.shared.helpTokens {
            someHelp.append(contentsOf: addList)
        }
        
        APGIntentMacTools.addHelpMenuIntents(help: someHelp)
        
        APGIntentActionList.sharedApp.addAction(token: APGIntent.about) { _ in
            APGWorkAbout.show()
        }
        
        APGIntentActionList.sharedApp.addAction(token: APGIntent.settings) { _ in
            APGWorkSettings.show()
        }
        
        APGIntentActionList.sharedApp.addAction(token: APGIntent.promos) { _ in
            APGWorkPromos.show()
        }
        
        APGIntentActionList.sharedApp.addAction(token: APGIntent.whatsnew) { _ in
            APGWorkWhatsNew.show()
        }

        APGIntentActionList.sharedApp.addAction(token: APGIntent.getStarted) { _ in
            APGWorkGetStarted.show()
         }

        APGIntentActionList.sharedApp.addAction(token: APGIntent.faq) { _ in
           APGWorkFAQ.show()
        }

        APGIntentActionList.sharedApp.addAction(token: APGIntent.welcome) { _ in
            APGWorkWelcome.show()
        }
    }
    
    /// Start App stuff
    @MainActor
    public static func appStart() {
    }
    
}

// MARK: - Extension

extension View {
    
    /// Set VIew Background color to Banner Color
    func APGWorkBackgroundBannerColor() -> some View {
        self.background(APGWorkAppSpecs.backgroundBannerColor)
    }
    
}

