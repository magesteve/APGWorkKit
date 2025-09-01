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

/// Information for a Promo tile
@MainActor
public struct APGWorkPromoTile: Decodable {
    public static var artHeight = 500
    public static var artWidth = 900
    
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
            let art = AttributedString.cantripImage(image, size: CGSize(width: APGWorkPromoTile.artWidth, height: APGWorkPromoTile.artHeight))
            result.cantripCentered(art)
            result.cantripParagraphEnd()
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
