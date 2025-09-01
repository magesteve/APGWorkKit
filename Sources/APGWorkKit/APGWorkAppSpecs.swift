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
        if APGWorkDebug.debugOn {
            APGIntentInfoList.shared.add(APGIntentInfo(token: APGIntent.debugToken(1), name: APGWorkDebug.debugName1 ?? APGWorkShared.unused))

            APGIntentInfoList.shared.add(APGIntentInfo(token: APGIntent.debugToken(2), name: APGWorkDebug.debugName2 ?? APGWorkShared.unused))

            APGIntentInfoList.shared.add(APGIntentInfo(token: APGIntent.debugToken(3), name: APGWorkDebug.debugName3 ?? APGWorkShared.unused))

            APGIntentInfoList.shared.add(APGIntentInfo(token: APGIntent.debugToken(4), name: APGWorkDebug.debugName4 ?? APGWorkShared.unused))

            APGIntentInfoList.shared.add(APGIntentInfo(token: APGIntent.debugToken(5), name: APGWorkDebug.debugName5 ?? APGWorkShared.unused))

            APGIntentInfoList.shared.add(APGIntentInfo(token: APGIntent.debugToken(6), name: APGWorkDebug.debugName6 ?? APGWorkShared.unused))

            APGIntentInfoList.shared.add(APGIntentInfo(token: APGIntent.debugToken(7), name: APGWorkDebug.debugName7 ?? APGWorkShared.unused))

            APGIntentInfoList.shared.add(APGIntentInfo(token: APGIntent.debugToken(8), name: APGWorkDebug.debugName8 ?? APGWorkShared.unused))
            
            if let action = APGWorkDebug.debugAction1 {
                APGIntentActionList.sharedApp.addAction(token: APGIntent.debugToken(1), action: action)
            }

            if let action = APGWorkDebug.debugAction2 {
                APGIntentActionList.sharedApp.addAction(token: APGIntent.debugToken(2), action: action)
            }

            if let action = APGWorkDebug.debugAction3 {
                APGIntentActionList.sharedApp.addAction(token: APGIntent.debugToken(3), action: action)
            }

            if let action = APGWorkDebug.debugAction4 {
                APGIntentActionList.sharedApp.addAction(token: APGIntent.debugToken(4), action: action)
            }

            if let action = APGWorkDebug.debugAction5 {
                APGIntentActionList.sharedApp.addAction(token: APGIntent.debugToken(5), action: action)
            }

            if let action = APGWorkDebug.debugAction6 {
                APGIntentActionList.sharedApp.addAction(token: APGIntent.debugToken(6), action: action)
            }

            if let action = APGWorkDebug.debugAction7 {
                APGIntentActionList.sharedApp.addAction(token: APGIntent.debugToken(7), action: action)
            }

            if let action = APGWorkDebug.debugAction8 {
                APGIntentActionList.sharedApp.addAction(token: APGIntent.debugToken(8), action: action)
            }

            APGIntentMacTools.addMenuBeforeHelp(named: APGWorkShared.debug, tokens: [
                APGIntent.debugToken(1),
                APGIntent.debugToken(2),
                APGIntent.debugToken(3),
                APGIntent.debugToken(4),
                APGIntent.debugToken(5),
                APGIntent.debugToken(6),
                APGIntent.debugToken(7),
                APGIntent.debugToken(8)
            ] )
        }

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

/// Debug Struct
@MainActor
public struct APGWorkDebug {
    // MARK: - Static Var
    
    /// Debug On
    public static var debugOn: Bool = false
    
    /// Debug 1 String
    public static var debugName1: String?
    
    /// Debug 1 Action
    public static var debugAction1: APGIntentActionClosure?
    
    /// Debug 2 String
    public static var debugName2: String?
    
    /// Debug 2 Action
    public static var debugAction2: APGIntentActionClosure?
    
    /// Debug 3 String
    public static var debugName3: String?
    
    /// Debug 3 Action
    public static var debugAction3: APGIntentActionClosure?
    
    /// Debug 4 String
    public static var debugName4: String?
    
    /// Debug 4 Action
    public static var debugAction4: APGIntentActionClosure?
    
    /// Debug 5 String
    public static var debugName5: String?
    
    /// Debug 5 Action
    public static var debugAction5: APGIntentActionClosure?
    
    /// Debug 6 String
    public static var debugName6: String?
    
    /// Debug 6 Action
    public static var debugAction6: APGIntentActionClosure?
    
    /// Debug 7 String
    public static var debugName7: String?
    
    /// Debug 7 Action
    public static var debugAction7: APGIntentActionClosure?
    
    /// Debug 8 String
    public static var debugName8: String?
    
    /// Debug 8 Action
    public static var debugAction8: APGIntentActionClosure?

}

// MARK: - Extension

extension View {
    
    /// Set VIew Background color to Banner Color
    func APGWorkBackgroundBannerColor() -> some View {
        self.background(APGWorkAppSpecs.backgroundBannerColor)
    }
    
}

