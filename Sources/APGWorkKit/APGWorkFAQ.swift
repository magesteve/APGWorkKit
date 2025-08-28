//
//  APGWorkFAQ.swift
//  MacDocSpike
//
//  Created by Steve Sheets on 8/19/25.
//

// MARK: Imports

import Foundation
import APGCantripKit
import APGWidgetKit

#if canImport(AppKit) && canImport(SwiftUI)

import AppKit
import SwiftUI

#endif

// MARK: - Structure

public struct APGWorkFAQEntry: Identifiable {
    public let id = UUID()
    public let question: String
    public let answer: String
}

public struct APGWorkFAQTopic: Identifiable {
    public let id = UUID()
    public let title: String
    public var entries: [APGWorkFAQEntry]
}

public struct APGWorkFAQReference: Identifiable {
    public let id = UUID()
    public let title: String
    public let ref: String
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
            title: APGWorkShared.faq,
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
