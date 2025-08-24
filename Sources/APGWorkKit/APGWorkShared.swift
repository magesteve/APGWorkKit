//
//  APGWorkShared.swift
//  APGWorkKit
//
//  Created by Steve Sheets on 8/17/25.
//
//  Static helpers + a MainActor-isolated state container for Work UI.
//

import Foundation
import SwiftUI
import APGCantripKit

// MARK: - Class

/// UI state and links used by Work UI. Main-thread only.
@MainActor
public final class APGWorkGlobals {
    // MARK: - Static Variables
    ///
    /// Singleton reference
    public static let shared = APGWorkGlobals()

    // MARK: - Public Variables

    /// Color used in Work UI (optional theme override)
    public var workUIColor: Color?

    /// About Symbol name to show in About
    public var aboutSymbolName: String = APGWorkShared.sfAboutLogo

    /// About Acknowledgments external reference (URL string or file path)
    public var aboutAcknowledgmentsLink: String = ""

    /// About Licenses external reference (URL string or file path)
    public var aboutLicensesLink: String = ""

    /// What's New features
    public var featuresList: [APGWorkFeatureItem] = []

    /// Optional external "Complete Feature List" reference (URL/file)
    public var featuresListLink: String = ""
        
    /// Additional about menu item Token
    public var aboutTokens: [String]?

    /// Additional help menu item Token
    public var helpTokens: [String]?

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
}

// MARK: - Enum

/// Static helpers for human-readable strings and bundle info.
public enum APGWorkShared {

    // MARK: Human Readable Localizations

    public static var ok: String { "OK" }
    public static var inString: String { "in" }
    public static var space: String { " " }
    public static var about: String { "About" }
    public static var whatsNew: String { "What's New" }
    public static var continueString: String { "Continue" }
    public static var welcome: String { "Welcome" }
    public static var faq: String { "FAQ" }
    public static var version: String { "Version" }
    public static var acknowledgments: String { "Acknowledgments" }
    public static var completeFeatureList: String { "Complete Feature List" }
    public static var licenses: String { "Licenses" }

    // MARK: Tokens

    public static let tokenWhatsNew = "whatsnew"
    public static let tokenAbout = "about"
    public static let tokenFAQ = "faq"
    public static let tokenWelcome = "welcome"

    // MARK: Identifiers

    public static let identifierAboutWindow   = "APGWork-About"
    public static let identifierWhatsNewWindow = "APGWork-WhatsNew"
    public static let identifierWelcomeWindow = "APGWork-Welcome"
    public static let identifierFAQWindow     = "APGWork-FAQ"

    // MARK: SF Symbols

    public static let sfAboutLogo   = "apple.logo"
    public static let sfAboutToken  = "info.circle"
    public static let sfWhatsNewToken = "sparkles"
    public static let sfFAQToken    = "questionmark.bubble"
    public static let sfWelcomeToken = "hand.wave"

    // MARK: Bundle-derived strings

    /// Title for About window.
    public static var aboutAppName: String {
        let name = APGCantrip.appName()

        guard name.isEmpty else { return about }
        
        return about + space + name
    }

    /// Title for What's New window.
    public static var whatsNewAppName: String {
        let name = APGCantrip.appName()

        guard name.isEmpty else { return whatsNew }
        
        return whatsNew + space + inString + space + name
    }
}
