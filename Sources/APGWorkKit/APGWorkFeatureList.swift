//
//  APGWorkFeatureList.swift
//  APGWorkKit
//
//  Created by Steve Sheets on 8/27/25.
//
//  A scrollable list of feature items with symbol, title, and description.
//

// MARK: - Import

import Foundation
import SwiftUI

// MARK: - SwiftUI Views

/// A scrollable list of feature items with symbol, title, and description.
public struct APGWorkMacFeatureList: View {
    public let listFeatureItem: [APGWorkFeatureItem]

    public init(listFeatureItem: [APGWorkFeatureItem]) {
        self.listFeatureItem = listFeatureItem
    }
    
    public var body: some View {
        LazyVStack(alignment: .leading, spacing: 28) {
            ForEach(Array(listFeatureItem.enumerated()), id: \.offset) { _, item in
                HStack(alignment: .top, spacing: 20) {
                    if !item.symbolName.isEmpty {
                        if let customColor = APGWorkAppHelper.workUIColor {
                            Image(systemName: item.symbolName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 45, height: 45)
                                .symbolRenderingMode(.monochrome)
                                .foregroundStyle(customColor)
                        } else {
                            Image(systemName: item.symbolName)
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 45, height: 45)
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text(item.title)
                            .font(.title2).bold()
                        Text(item.description)
                            .font(.system(size: 18))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 160)
            }
        }
        .padding(.top, 32)
    }
}

