//
//  APGWorkShared.swift
//  APGWorkKit
//
//  Created by Steve Sheets on 8/17/25.
//
//  Static helpers + a MainActor-isolated state container for Work UI.
//

// MARK: - Import

import Foundation
import APGCantripKit

// MARK: - Enum

/// Static helpers for human-readable strings and bundle info.
public enum APGWorkShared {
    
    // MARK: Human Readable Localizations
    
    public static let ok: String = "OK"
    public static let inString: String = "in"
    public static let toString: String = "to"
    public static let space: String = " "
    public static let about: String = "About"
    public static let whatsNew: String = "What's New"
    public static let continueString: String = "Continue"
    public static let welcome: String = "Welcome"
    public static let settings: String = "Settings"
    public static let promos: String = "Promotions"
    public static let faq: String = "FAQ"
    public static let getStarted: String = "Get Started"
    public static let newDocument: String = "New Document"
    public static let openDocuments: String = "Open Documents"
    public static let version: String = "Version"
    public static let acknowledgments: String = "Acknowledgments"
    public static let completeFeatureList: String = "Complete Feature List"
    public static let newFeatureList: String = "New Feature List"
    public static let licenses: String = "Licenses"
    
    // MARK: Identifiers
    
    public static let identifierAboutWindow = "APGWork-About"
    public static let identifierWhatsNewWindow = "APGWork-WhatsNew"
    public static let identifierWelcomeWindow = "APGWork-Welcome"
    public static let identifierFAQWindow = "APGWork-FAQ"
    public static let identifierGetStartedWindow = "APGWork-GetStarted"
    public static let identifierSettingsWindow = "APGWork-Settings"
    public static let identifierPromosWindow = "APGWork-Promos"

    // MARK: SF Symbols
    
    public static let sfAboutLogo   = "apple.logo"
    
    public static let sfAboutToken  = "info.circle"
    public static let sfWhatsNewToken = "sparkles"
    public static let sfWelcomeToken = "hand.wave"
    public static let sfFAQToken    = "questionmark.bubble"
    public static let sfGetStartedToken = "hand.wave"
    public static let sfSettingsToken = "hand.wave"
    public static let sfPromosToken = "hand.wave"
    
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
    
    /// Title for What's New window.
    public static var welcomeToAppName: String {
        let name = APGCantrip.appName()

        guard name.isEmpty else { return welcome }
        
        return welcome + space + toString + space + name
    }
}
