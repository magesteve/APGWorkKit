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
        var listTokens: [String] = []
        
        listTokens = [APGWorkShared.tokenAbout]
        if let addList = APGWorkGlobals.shared.aboutTokens {
            listTokens.append(contentsOf: addList)
        }
        APGIntentMacTools.addAppMenuIntents(about: listTokens)

        listTokens = [String(), APGWorkShared.tokenWhatsNew]
        if let addList = APGWorkGlobals.shared.helpTokens {
            listTokens.append(contentsOf: addList)
        }
        APGIntentMacTools.addHelpMenuIntents(help: listTokens)
        
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
    
}

#endif
