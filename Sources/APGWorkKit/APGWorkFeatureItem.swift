//
//  APGWorkFeatureItem.swift
//  APGWorkKit
//
//  Created by Steve Sheets on 8/18/25.
//
//  Represents a single feature item with an image, title, and description,
//  and supports Codable for export/import.
//

// MARK: - Import

import Foundation

// MARK: - Structure

/// Represents a single feature item in the What's New or feature promotion UI.
/// Includes title, description, optional image name, and full Codable/JSONAble support.
public struct APGWorkFeatureItem: Identifiable, Hashable, Equatable, Codable {

    // MARK: - Properties

    /// The title of the feature item (e.g., New PDF Export).
    public let title: String

    /// A brief description of what the feature does.
    public let description: String

    /// Optional system image or custom image identifier for the feature.
    public let symbolName: String

    /// A unique identifier for the feature item.
    public let id: UUID

    // MARK: - Init

    /// Initializes a new feature item.
    /// - Parameters:
    ///   - title: A short title describing the feature.
    ///   - description: A short explanation of the feature's purpose.
    ///   - symbolName: An optional symbolic name representing an image.
    ///   - ident: A UUID (optional, defaults to new UUID).
    public init(title: String,
                description: String,
                symbolName: String = String(),
                ident: UUID = UUID()) {
        self.title = title
        self.description = description
        self.symbolName = symbolName
        self.id = ident
    }

}
