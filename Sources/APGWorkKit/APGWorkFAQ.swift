//
//  APGWorkFAQ.swift
//  APGWorkKit
//
//  Created by Steve Sheets on 8/19/25.
//

// MARK: Imports

import Foundation
import APGCantripKit
import APGWidgetKit
import SwiftUI

#if canImport(AppKit)

import AppKit

#endif

// MARK: - Structure

/// Single Quest & Answer for FAQ
public struct APGWorkFAQEntry: Identifiable {
    
    /// Unique identifier
    public let id = UUID()
 
    /// Question
    public let question: String
    
    /// Answer
    public let answer: String
    
    /// Public Init
    public init(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
}

/// List of Entry with topic title
public struct APGWorkFAQTopic: Identifiable {

    /// Unique identifier
    public let id = UUID()

    /// Title of topic
    public let title: String

    /// List of entries (Q & A)
    public var entries: [APGWorkFAQEntry]
    
    /// Public Init
    public init(title: String, entries: [APGWorkFAQEntry]) {
        self.title = title
        self.entries = entries
    }
}

/// Reference (doc or html) to display Title, and open Ref
public struct APGWorkFAQReference: Identifiable {
    
    /// Unique identifier
    public let id = UUID()
    
    /// Title of Reference
    public let title: String
    
    /// Ref string (url or file name) of Reference
    public let ref: String
    
    /// Public Init
    public init(title: String, ref: String) {
        self.title = title
        self.ref = ref
    }
}

// MARK: - Class

/// Static manager for the FAQ window..
@MainActor
public final class APGWorkFAQ {

    // MARK: - Init

    private init() {}

    // MARK: - Show Window

    /// Show the FAQ window using filled values.
    public static func show() {
        APGWidgetWindow.makeWindow(
            title: APGWorkShared.faqForAppName,
            ident: APGWorkShared.identifierFAQWindow,
            size: CGSize(width: 500, height: 600)
        ) {
            APGWorkMacFAQView(
                topics: APGWorkAppHelper.shared.faqTopics,
                references: APGWorkAppHelper.shared.faqReferences,
            )
        }
    }
}

// MARK: - SwiftUI View

private struct APGWorkMacFAQView: View {
    let topics: [APGWorkFAQTopic]
    let references: [APGWorkFAQReference]

    @State public var expandedIDs = Set<UUID>()

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(topics) { topic in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(topic.title)
                                .font(.title2)
                                .bold()

                            ForEach(topic.entries) { entry in
                                DisclosureGroup(
                                    isExpanded: Binding(
                                        get: { expandedIDs.contains(entry.id) },
                                        set: { newValue in
                                            if newValue {
                                                expandedIDs.insert(entry.id)
                                            } else {
                                                expandedIDs.remove(entry.id)
                                            }
                                        }
                                    )
                                ) {
                                    Text("A: \(entry.answer)")
                                        .padding(.leading, 10)
                                        .padding(.top, 4)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                } label: {
                                    Text("Q: \(entry.question)")
                                        .bold()
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }

            Divider()

            HStack {
                Spacer()
                ForEach(references) { ref in
                    Button(ref.title) {
                        APGCantrip.openRef(ref.ref)
                    }
                }
            }
            .padding(8)
            .background(Color.gray.opacity(0.15))
        }
    }
}
