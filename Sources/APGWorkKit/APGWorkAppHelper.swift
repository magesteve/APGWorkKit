//
//  APGWorkAppHelper.swift
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

#if canImport(SwiftUI)

import SwiftUI

#endif

// MARK: - Class

/// Static class for Work UI
@MainActor
public class APGWorkAppHelper {
    
    // MARK: - Static Variables
    ///
    /// Singleton reference
    public static let shared = APGWorkAppHelper()

    // MARK: - Public Variables

    /// Color used in Work UI (optional theme override)
    public var workRGB: APGCantripRGB?

    /// About Symbol name to show in About
    public var aboutSymbolName: String = APGWorkShared.sfAboutLogo

    /// About Acknowledgments external reference (URL string or file path)
    public var aboutAcknowledgmentsLink = String()

    /// About Licenses external reference (URL string or file path)
    public var aboutLicensesLink = String()

    /// What's New features
    public var featuresList: [APGWorkFeatureItem] = []

    /// Optional external "Complete Feature List" reference (URL/file)
    public var featuresListLink: String = ""
        
    /// Additional about menu item Token
    public var aboutTokens: [String]?

    /// Additional help menu item Token
    public var helpTokens: [String]?
    
    /// Welcome subtitle
    public var welcomeSubTitle = String()

    /// Welcome Agreement Reference
    public var welcomeAgreementRef: String? = nil

    /// Welcome List of Image names to display
    public var welcomeImageNames: [String] = []

    // MARK: - COmputed Var
    
    public static var workUIColor: Color? {
        guard let rgb = APGWorkAppHelper.shared.workRGB else { return nil }
        
        return rgb.swiftUIColor
    }


    // MARK: - Init
    
    /// do nothing init
    public init() {}
    
    // MARK: - Public Functions

    /// Add additional items to premade intents
    public func addAdditionalMenuIntents(about: [String]? = nil,
                                         help: [String]? = nil) {
        self.aboutTokens = about
        self.helpTokens = help
    }
    // MARK: - Static Function
    
    /// Init App stuff
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
            APGIntentInfo(token: APGIntent.features,
                          name: APGWorkShared.getStarted,
                          symbolName: APGWorkShared.sfGetStartedToken)
        ])
    }
    
    /// Setup App stuff
    public static func appPrepare() {
        var listTokens: [String] = []
        
        listTokens = [APGIntent.about]
        if let addList = APGWorkAppHelper.shared.aboutTokens {
            listTokens.append(contentsOf: addList)
        }
        APGIntentMacTools.addAppMenuIntents(about: listTokens)

        listTokens = [String(), APGIntent.whatsnew]
        if let addList = APGWorkAppHelper.shared.helpTokens {
            listTokens.append(contentsOf: addList)
        }
        APGIntentMacTools.addHelpMenuIntents(help: listTokens)
        
        APGIntentActionList.sharedApp.addAction(token: APGIntent.about) { _ in
            APGWorkAbout.show()
        }

        APGIntentActionList.sharedApp.addAction(token: APGIntent.whatsnew) { _ in
            APGWorkWhatsNew.show()
        }

        APGIntentActionList.sharedApp.addAction(token: APGIntent.features) { _ in
         }

        APGIntentActionList.sharedApp.addAction(token: APGIntent.faq) { _ in
        }

        APGIntentActionList.sharedApp.addAction(token: APGIntent.welcome) { _ in
            APGWorkWelcome.show()
        }
    }
    
    /// Start App stuff
    public static func appStart() {
    }
    
}
