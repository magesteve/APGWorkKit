//
//  APGWorkMacApp.swift
//  APGWorkKit
//
//  Created by Steve Sheets on 8/17/25.
//
//  App level function relating to Work UI
//

import APGIntentKit

#if os(macOS)
import Cocoa

// MARK: - Class

/// Static class for Work UI for MacOS
@MainActor
public class APGWorkMacApp {
    
    // MARK: - Static Function
    
    /// Init App stuff
    public static func appInit() {
        APGIntentInfoList.shared.add(contentsOf: [
            APGIntentInfo(token: APGWorkShared.tokenAbout,
                          name: APGWorkShared.aboutAppName,
                          symbolName: APGWorkShared.sfAboutToken),
            APGIntentInfo(token: APGWorkShared.tokenWhatsNew,
                          name: APGWorkShared.whatsNewAppName,
                          symbolName: APGWorkShared.sfWhatsNewToken)
        ])
    }
    
    /// Setup App stuff
    public static func appPrepare() {
        APGIntentMacTools.addAppMenuIntents(about: [ APGWorkShared.tokenAbout ] )
        APGIntentMacTools.addHelpMenuIntents(help: [ String(), APGWorkShared.tokenWhatsNew ] )

        APGIntentActionList.sharedApp.addAction(token: APGWorkShared.tokenAbout) { _ in
            APGWorkMacAbout.show()
        }

        APGIntentActionList.sharedApp.addAction(token: APGWorkShared.tokenWhatsNew) { _ in
            APGWorkMacWhatsNew.show()
        }
    }
    
    /// Start App stuff
    public static func appStart() {
    }
    
    /// Open Reference (URL, PDF, other)
    public static func openRef(_ text: String) {
        guard !text.isEmpty else { return }
        
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmed.range(of: APGWorkShared.regexIsUrl, options: [.regularExpression, .caseInsensitive]) != nil {
            guard let url = URL(string: trimmed) else {
                return
            }
            
            NSWorkspace.shared.open(url)
        } else if trimmed.range(of: APGWorkShared.regexIsOpenableFile, options: [.regularExpression, .caseInsensitive]) != nil {
            let fileURL: URL?
            
            // First try loading from bundle (embedded resources)
            if let resourceURL = Bundle.main.url(forResource: trimmed, withExtension: nil) {
                fileURL = resourceURL
            } else {
                // Fall back to assuming it's a full path
                fileURL = URL(fileURLWithPath: trimmed)
            }
            
            if let fileURL = fileURL, FileManager.default.fileExists(atPath: fileURL.path) {
                NSWorkspace.shared.open(fileURL)
            }
        }
    }
}

#endif
