//
//  APGWorkPromoTile.swift
//  APGWorkKit
//
//  Created by Steve Sheets on 8/30/25.
//

// MARK: - Import

import Foundation
import APGCantripKit

// MARK: - Structure

public struct APGWorkPromoTile: Decodable {
    public var title: String?
    public var body: String?
    public var imageName: String?
    public var linkTitle: String?
    public var linkRef: String?
    
    public init(title: String? = nil, body: String? = nil, imageName: String? = nil, linkTitle: String? = nil, linkRef: String? = nil) {
        self.title = title
        self.body = body
        self.imageName = imageName
        self.linkTitle = linkTitle
        self.linkRef = linkRef
    }
    
    @MainActor
    public func makeAttributedString() -> AttributedString {
        var result = AttributedString()
        
        if let imageName,
            let image = APGCantripImage(named: imageName) {
            result.cantripImage(image)
        }
        
        if let title {
            let text = AttributedString.cantripH1(title)
            result.cantripCentered(text)
        }
        
        if let body {
            result.cantripP(body)
        }
        
        if let linkTitle {
            result.cantripBannerLink(linkTitle, linkRef ?? String())
        }
        
        return result
    }
}
