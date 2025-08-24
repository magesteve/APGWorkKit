//
//  APGWorkString.swift
//  APGWorkKit
//
//  Created by Steve Sheets on 8/17/25.
//
//  Static class to help display human readable strings
//

import Foundation
import SwiftUI

// MARK: - Class

/// Static class to help display human readable strings
public class APGWorkShared {
    
    // MARK: - Static UI Var
    
    /// Color used in Work UI
    public static var workUIColor: Color?

    // About Variables
    
    /// About Symbol name to show in About
    public static var aboutSymbolName = APGWorkShared.sfAboutLogo
    
    /// About Acknowledments button external reference
    public static var aboutAcknowledgmentsLink = String()

    /// About Licenses button external reference
    public static var aboutLicensesLink = String()

    /// Whats New features
    public static var featuresList: [APGWorkFeaturesItem] = []

    /// Whats New features List Ref
    public static var featuresListLink = String()

    // MARK: - Human Readable Localizations Constants
    
    /// Human readable: OK
    public static var ok: String { "OK" }
    
    /// Human readable: in
    public static var inString: String { "in" }
    
    /// Human readable: space or ' '
    public static var space: String { " " }
    
    /// Human readable: About
    public static var about: String { "About" }
    
    /// Human readable: What's New
    public static var whatsNew: String { "What's New" }
    
    /// Human readable: Continue
    public static var continueString: String { "Continue" }
    
    /// Human readable: Welcome
    public static var welcome: String { "Welcome" }
    
    /// Human readable: FAQ
    public static var faq: String { "FAQ" }

    /// Human readable: Version
    public static var version: String { "Version" }

    /// Human readable: Acknowledgments
    public static var acknowledgments: String { "Acknowledgments" }

    /// Human readable: Acknowledgments
    public static var completeFeatureList: String { "Complete Feature List" }

    /// Human readable: Licenses
    public static var licenses: String { "Licenses" }

    // MARK: - Tokens Constants
    
    /// What's New token
    public static let tokenWhatsNew = "whatsnew"
    
    /// About token
    public static let tokenAbout = "about"
    
    /// FAQ token
    public static let tokenFAQ = "faq"
    
    /// Welcome token
    public static let tokenWelcome = "welcome"

    // MARK: - Identifiers Constants
    
    /// Window About Identifiers
    public static let identifierAboutWindow = "APGWork-About"
    
    /// Window What's New Identifiers
    public static let identifierWhatsNewWindow = "APGWork-WhatsNew"
    
    /// Window Welcome Identifiers
    public static let identifierWelcomeWindow = "APGWork-Welcome"
    
    /// Window FAQ Identifiers
    public static let identifierFAQWindow = "APGWork-FAQ"
    
    // MARK: - SF Symbols Constants
    
    /// About Window logo
    public static let sfAboutLogo = "apple.logo"
    
    /// About Token Symbol
    public static let sfAboutToken = "info.circle"
    
    /// What's New Token Symbol
    public static let sfWhatsNewToken = "sparkles"
    
    /// FAQ Token Symbol
    public static let sfFAQToken = "questionmark.bubble"
    
    /// Welcome Token Symbol
    public static let sfWelcomeToken = "hand.wave"

    // MARK: - Regex Constants
    
    public static let regexIsUrl = #"^(https?://)[^\s/$.?#].[^\s]*$"#
    
    public static let regexIsOpenableFile = #"^.+\.(pdf|txt|jpg|mpg)$"#.lowercased()

    // MARK: - Calculated Var Constants
    
    /// Return App Name from Bundle
    public static var appName: String? {
        let nameKey = kCFBundleNameKey as String
        return Bundle.main.object(forInfoDictionaryKey: nameKey) as? String
    }
    
    /// Return App Version from Bundle
    public static var appVersionString: String {
        let versionKey = "CFBundleShortVersionString"
        let version = Bundle.main.object(forInfoDictionaryKey: versionKey) as? String ?? "1.0"

        let buildKey = kCFBundleVersionKey as String
        let build = Bundle.main.object(forInfoDictionaryKey: buildKey) as? String ?? String()

        return APGWorkShared.version + APGWorkShared.space + version + APGWorkShared.space + build
    }
    
    /// Return Copywrite from Bundle
    public static var copyrightString: String? {
        Bundle.main.object(forInfoDictionaryKey: "NSHumanReadableCopyright") as? String
    }

    /// Return About app name
    public static var aboutAppName: String {
        var title = APGWorkShared.about
        if let name = APGWorkShared.appName {
            title = title + APGWorkShared.space + name
        }
        return title
    }

    /// Return What's New app name
    public static var whatsNewAppName: String {
        var title = APGWorkShared.whatsNew
        if let name = APGWorkShared.appName {
            title = title + APGWorkShared.space + APGWorkShared.inString + APGWorkShared.space + name
        }
        return title
    }

}
