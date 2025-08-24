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

// MARK: - Class

/// UI state and links used by Work UI. Main-thread only.
@MainActor
public final class APGWorkGlobals {
    /// Singleton reference
    public static let shared = APGWorkGlobals()

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

    private init() {}
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

    // MARK: Regex

    public static let regexIsUrl = #"^(https?://)[^\s/$.?#].[^\s]*$"#
    public static let regexIsOpenableFile = #"^.+\.(pdf|txt|jpg|mpg)$"#.lowercased()

    // MARK: Bundle-derived strings

    /// App name from bundle.
    public static var appName: String? {
        let nameKey = kCFBundleNameKey as String
        return Bundle.main.object(forInfoDictionaryKey: nameKey) as? String
    }

    /// "Version X.Y.Z (Build)" string.
    public static var appVersionString: String {
        let versionKey = "CFBundleShortVersionString"
        let version = Bundle.main.object(forInfoDictionaryKey: versionKey) as? String ?? "1.0"

        let buildKey = kCFBundleVersionKey as String
        let build = Bundle.main.object(forInfoDictionaryKey: buildKey) as? String ?? ""

        return APGWorkShared.version + APGWorkShared.space + version + (build.isEmpty ? "" : APGWorkShared.space + build)
    }

    /// Copyright from bundle, if present.
    public static var copyrightString: String? {
        Bundle.main.object(forInfoDictionaryKey: "NSHumanReadableCopyright") as? String
    }

    /// Title for About window.
    public static var aboutAppName: String {
        if let name = appName {
            return about + space + name
        }
        return about
    }

    /// Title for What's New window.
    public static var whatsNewAppName: String {
        if let name = appName {
            return whatsNew + space + inString + space + name
        }
        return whatsNew
    }
}
