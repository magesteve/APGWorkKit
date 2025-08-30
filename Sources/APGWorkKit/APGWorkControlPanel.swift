//
//  APGWorkControlPanel.swift
//  APGWorkKit
//
//  Created by Steve Sheets on 8/29/25.
//

// MARK: Imports

import Foundation
import SwiftUI
import APGIntentKit


// MARK: - Class

/// Abstract class for all Control Panels
@MainActor
open class APGWorkControlPanel {
    
    // MARK: - Variables
    
    /// Intent token to show panel, also used for identification
    public let token: String
    
    /// Computed panel name from the intent info, or fallback.
    public var panelName: String {
        APGIntentInfoList.shared.find(token: token)?.shortName ?? APGWorkShared.settings
    }

    // MARK: - Public functions

    /// Designated initializer
    public init(token: String) {
        self.token = token
    }
    
    /// Register this control panel into settings and setup actions/info. Token must be set!
    public func registerControlPanel(name: String, shortName: String, symbolName: String) {
        let i = self.token
        
        APGWorkSettings.listControlPanels.append(self)
        
        APGIntentInfoList.shared.add(
            APGIntentInfo(token: i, name: name, shortName: shortName, symbolName: symbolName),
        )
        APGIntentActionList.sharedApp.addAction(token: i) { _ in
            APGWorkSettings.show(token:i)
        }
        
    }
    
    /// Abstract call to provide the actual Control Panel view.
    @ViewBuilder
    open func makeControlPanelView() -> any View {
        fatalError("Subclasses must override makeView()")
    }
}
